# Generated by Django 4.1.3 on 2022-11-05 18:52

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0003_listing_status'),
    ]

    operations = [
        migrations.AddField(
            model_name='book',
            name='description',
            field=models.TextField(default='this is book description'),
            preserve_default=False,
        ),
    ]
