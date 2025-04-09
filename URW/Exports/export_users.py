import xml.etree.ElementTree as ET
import pandas as pd

# Charger le fichier XML
xml_file = "users.xml"  # Remplace par le nom de ton fichier XML

# Parser le fichier XML
tree = ET.parse(xml_file)
root = tree.getroot()

# Liste pour stocker les données extraites
data = []

# Extraire les informations des résultats
for result in root.findall("Results"):
    row_data = {}

    # Extraire les éléments simples
    for elem in result:
        if elem.tag == "Client":
            row_data["Client ID"] = elem.find("ID").text if elem.find("ID") is not None else ""
        elif elem.tag == "PartnerProperties":
            # Gérer les PartnerProperties séparément
            name = elem.find("Name").text if elem.find("Name") is not None else ""
            value = elem.find("Value").text if elem.find("Value") is not None else ""
            row_data[name] = value  # Ajoute dynamiquement en tant que colonne
        else:
            row_data[elem.tag] = elem.text if elem.text is not None else ""

    # Ajouter la ligne complète
    data.append(row_data)

# Convertir en DataFrame pandas
df = pd.DataFrame(data)

# Sauvegarder en fichier Excel
output_file = "output.xlsx"
df.to_excel(output_file, index=False)

print(f"✅ Fichier Excel généré avec succès : {output_file}")