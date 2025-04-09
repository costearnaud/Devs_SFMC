import os
import lxml.etree as ET
import xmltodict
from openpyxl import Workbook

def convertir_xml_en_excel(fichier_xml, fichier_excel):
    try:
        # 1. Transformation XSLT
        script_dir = os.path.dirname(os.path.abspath(__file__))
        xslt_path = os.path.join(script_dir, "transform.xslt")

        if not os.path.exists(xslt_path):
            raise FileNotFoundError(f"Fichier XSLT non trouvé: {xslt_path}")

        xslt = ET.parse(xslt_path)
        transform = ET.XSLT(xslt)

        dom = ET.parse(fichier_xml)
        result = transform(dom)

        # 2. Conversion en dictionnaire
        xml_dict = xmltodict.parse(str(result))

        # 3. Création du fichier Excel
        workbook = Workbook()
        sheet = workbook.active

        results_list = xml_dict.get('Results', {}).get('Results', [])

        if isinstance(results_list, dict):
            results_list = [results_list]

        if results_list:
            # Extraction des en-têtes (du premier élément <Results>)
            headers = []
            for key, value in results_list[0].items():
                if key == 'PartnerProperties':  # Cas spécifique pour <PartnerProperties>
                    for item in value:
                        headers.append(item['Name'])
                elif isinstance(value, dict):  # Cas d'un dictionnaire avec un seul enfant (comme <Client>)
                    for sub_key in value:
                        headers.append(f"{key}.{sub_key}")
                else:
                    headers.append(key)
            sheet.append(headers)

            # Extraction des données
            for result in results_list:
                row = []
                for key, value in result.items():
                    if key == 'PartnerProperties':  # Cas spécifique pour <PartnerProperties>
                        for item in value:
                            row.append(item['Value'])
                    elif isinstance(value, dict):  # Cas d'un dictionnaire avec un seul enfant
                        for sub_key, sub_value in value.items():
                            row.append(sub_value)
                    elif value is None:
                        row.append("")
                    else:
                        row.append(value)
                sheet.append(row)

            workbook.save(fichier_excel)
            print(f"Fichier converti et enregistré sous: {fichier_excel}")
        else:
            print("Aucun élément <Results> trouvé dans le fichier XML transformé.")

    except FileNotFoundError as e:
        print(f"Erreur: {e}")
    except ET.XMLSyntaxError as e:
        print(f"Erreur de syntaxe dans le fichier XSLT: {e}")
    except KeyError as e:
        print(f"Erreur: clé '{e}' non trouvée dans le dictionnaire XML. Vérifiez la structure de votre XML et/ou le fichier XSLT.")
        print(xml_dict)
    except Exception as e:
        print(f"Une erreur s'est produite: {e}")


# Exemple d'utilisation (à adapter)
fichier_xml = "users_SFMC.xml"  # Remplacez par le chemin de votre fichier XML
fichier_excel = "output.xlsx"  # Remplacez par le chemin de votre fichier Excel de sortie
convertir_xml_en_excel(fichier_xml, fichier_excel)