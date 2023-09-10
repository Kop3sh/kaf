from django.db import models
from django.core.validators import MinValueValidator, MaxValueValidator
from import_export import resources


class Customer(models.Model):
    name = models.CharField(max_length=255, unique=True, null=False)
    salary = models.PositiveIntegerField(null=False)
    percentage = models.DecimalField(
        max_digits=5,
        decimal_places=2,
        null=False,
        validators=[MinValueValidator(0.00), MaxValueValidator(100.00)],
    )

    def __str__(self) -> str:
        return self.name


class CustomerResource(resources.ModelResource):
    class Meta:
        model = Customer
        import_id_fields = ["name"]
        # import process will check each defined import field and perform a simple comparison with the existing instance, and if all comparisons are equal, then the row is skipped. Skipped rows are recorded in the row Result object.
        skip_unchanged = True
        # bulk_update() cannot be used with primary key fields.
        # use_bulk = True
