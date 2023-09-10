from django.contrib import admin
from django.urls import path
from insurance.views import ImportCustomerData, CustomersList

urlpatterns = [
    path("admin/", admin.site.urls),
    path(
        "customers",
        CustomersList.as_view(),
        name="customers-list",
    ),
    path(
        "import-customer-data/",
        ImportCustomerData.as_view(),
        name="import-customer-data",
    ),
]
