import sqlite3
import json

# Path to the SQLite database file
db_path = r'R:\_CODE\cocktail-chooser\CocktailChooser.Data\Data\CocktailChooser.db'

# Connect to the SQLite database
conn = sqlite3.connect(db_path)
cursor = conn.cursor()

# Query to get all cocktail information
query = """
SELECT
    c.Name AS CocktailName,
    c.Description,
    c.Method,
    gt.Name AS GlassType,
    ctp.Name AS TimePeriod,
    c.IsPopular,
    cs.Name AS Source,
    ci.AmountId,
    a.MeasurementName AS Amount,
    i.Name AS Ingredient,
    COALESCE(it.Type, 'Unknown') AS IngredientType  -- Handle possible NULL values
FROM Cocktails c
LEFT JOIN GlassTypes gt ON c.GlassTypeId = gt.Id
LEFT JOIN CocktailTimePeriods ctp ON c.TimePeriodId = ctp.Id
LEFT JOIN CocktailSource cs ON c.CocktailSourceID = cs.Id
LEFT JOIN CocktailIngredients ci ON c.Id = ci.CocktailId
LEFT JOIN Ingredients i ON ci.IngredientId = i.Id
LEFT JOIN IngredientTypes it ON i.IngredientTypeId = it.Id
LEFT JOIN Amounts a ON ci.AmountId = a.Id
ORDER BY c.Name
"""

# Execute the query and fetch all results
cursor.execute(query)
rows = cursor.fetchall()

# Get column names
column_names = [description[0] for description in cursor.description]

# Close the connection to the database
conn.close()

# Organize the data by cocktail
cocktails = {}
for row in rows:
    cocktail_name = row[0]
    if cocktail_name not in cocktails:
        cocktails[cocktail_name] = {
            'Description': row[1],
            'Method': row[2],
            'GlassType': row[3],
            'TimePeriod': row[4],
            'IsPopular': row[5],
            'Source': row[6],
            'Ingredients': []
        }
    ingredient_info = {
        'Amount': row[8],
        'Ingredient': row[9],
        'IngredientType': row[10]
    }
    cocktails[cocktail_name]['Ingredients'].append(ingredient_info)

# Convert the data to JSON
json_data = json.dumps(cocktails, indent=4)

# Save the JSON data to a file
json_file_path = 'Cocktails_Data.json'
with open(json_file_path, 'w') as json_file:
    json_file.write(json_data)

print(f'JSON data has been saved to {json_file_path}')
