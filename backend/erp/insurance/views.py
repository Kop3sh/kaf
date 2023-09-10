from rest_framework import generics, status
from rest_framework.response import Response
from rest_framework.parsers import MultiPartParser

import pandas as pd
from tablib import Dataset

from .models import CustomerResource, Customer
from .serializers import CustomerSerializer


class CustomersList(generics.ListAPIView):
    serializer_class = CustomerSerializer

    def get_queryset(self):
        """
        Optionally restricts the returned purchases to a given user,
        by filtering against a `username` query parameter in the URL.
        """
        queryset = Customer.objects.all()
        name = self.request.query_params.get("name")
        if name is not None:
            queryset = queryset.filter(name__icontains=name)
        return queryset


class ImportCustomerData(generics.GenericAPIView):
    parser_classes = [MultiPartParser]

    def post(self, request, *args, **kwargs):
        file = request.FILES["File"]
        df = pd.read_excel(file)

        """Rename the headeers in the excel file
           to match Django models fields"""

        rename_columns = {
            "Name": "name",
            "Salary": "salary",
            "Percentage": "percentage",
        }

        df.rename(columns=rename_columns, inplace=True)

        # filtering rows only having constrained salary and percentage values
        df = df[(df.percentage <= 100) & (df.percentage >= 0) & (df.salary > 0)]

        # Call the Student Resource Model and make its instance
        customer_resource = CustomerResource()

        # Load the pandas dataframe into a tablib dataset
        dataset = Dataset().load(df)

        # Call the import_data hook and pass the tablib dataset
        result = customer_resource.import_data(dataset, dry_run=True, raise_errors=True)

        if not result.has_errors():
            result = customer_resource.import_data(dataset, dry_run=False)
            return Response({"status": "Salary Data Imported Successfully"})

        return Response(
            {"status": "Not Imported Salary Data"}, status=status.HTTP_400_BAD_REQUEST
        )
