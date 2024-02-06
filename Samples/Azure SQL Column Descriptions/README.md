## Automatically update Azure SQL Column description using pyapacheatlas

The pyapacheatlas python library provides methods to the user to interact with the Apache Atlas services running behind Microsoft Purview.

https://github.com/wjohnson/pyapacheatlas

### Azure SQL

To start this work, we need an Azure SQL server and database.

Next, we need to leverage "extended properties" to describe our tables.

Extended properties allow us to create a table of metadata about our data.

If you look at the SQL commands in the SQL_Extended_Properties.sql file, you will find an example table called "Orders".

I create the table and add some sample data.

Next, I use the SQL stored procedure "sp_addextendedproperty" to add metadata about my table.

In this example I have created two extended properties: owner and description.

Then I create a view on top of the DMVs in SQL to easily query this metadata later.

### pyapacheatlas

I used Microsoft Fabric for this example but any spark engine or python script will work.

Open the python notebook "Purview Azure SQL Column Description.ipynb".

First I install the pyapacheatlas package.

I import several libraries but make note of the libraries imported from the pyapacheatlas package.

Next, I use Azure Key Vault to retrieve all of the secrets that will be used in this example:

- SQL user name
- SQL password
- Entra ID tenant ID
- Azure App registration client ID (for connecting to Purview)
- Azure app registration client secret
- Azure SQL server URI
- Name of my Purview instance

I use the ServicePrincipalAuthentication class to configure authentication parameters. I then use the PurviewClient class to configure the client to connect to Purview.

Next, I define a couple of python functions to do some repeatable work:
- Check if an entity exists in Purview
- Update a Purview entity
- Get a column description by parsing extended properties metadata data from a data frame

I then configure the settings needed to connect to Azure SQL using the jdbc driver shipped with Microsoft Fabric. And I define my SQL query which will query the view I created earlier.

Using the _spark.read.jdbc()_ method, I load the extended properties to a data frame from the view I created in SQL.

I then use the Purview client to make sure an entity exists for my SQL table.

This returns a dictionary that needs to be parsed in python to suit our needs. I strip the dictionary down to only the columns which exist in the "relationshipAttributes" object in the dictionary.

I build a new dictionary with only the name and guid of columns to make updating them easier.

Finally, using the name of the column I check for a description in the data frame. If a description is returned I use that to update the column description in Purview using the _update_entity()_ function.


