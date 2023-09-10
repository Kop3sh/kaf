from django.contrib import admin
from insurance.models import Customer, CustomerResource
from import_export.admin import ImportExportModelAdmin


class CustomerAdmin(ImportExportModelAdmin):
    resource_classes = [CustomerResource]
    list_display = (
        "name",
        "salary",
        "percentage",
    )


# Register your models here.
admin.site.register(Customer, CustomerAdmin)
