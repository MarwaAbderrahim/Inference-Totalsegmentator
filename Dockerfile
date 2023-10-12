# Utilisez une image de base Python
FROM python:3.10

# Définissez le répertoire de travail dans le conteneur
WORKDIR /inference

# ADD . /workspace

RUN chown -R 42420:42420 /inference

# Créer les répertoires de données
RUN mkdir -p /inference/data/input/nnUNet_raw_data
RUN mkdir -p /inference/data/input/nnUNet_preprocessed
RUN mkdir -p /inference/data/nnUNet_results
RUN mkdir -p /inference/data/input/nnUNet_cropped_data
# RUN mkdir -p /totalsegmentator_inference/models/nnUNet_raw_data

# Changer les propriétés des répertoires de données
RUN chown -R 42420:42420 /inference/data/input/nnUNet_raw_data
RUN chown -R 42420:42420 /inference/data/input/nnUNet_preprocessed
RUN chown -R 42420:42420 /inference/data/nnUNet_results

# Définir les permissions pour les répertoires de données
RUN chmod -R 777 /inference/data/input/nnUNet_raw_data
RUN chmod -R 777 /inference/data/input/nnUNet_preprocessed
RUN chmod -R 777 /inference/data/nnUNet_results
# Copiez les fichiers requis dans le conteneur
COPY TotalSegmentator.py /inference/TotalSegmentator.py

# Installez les dépendances Python
RUN pip install totalsegmentator

RUN pip install DicomRTTool

RUN pip install nnunet

RUN apt-get update && apt-get install -y libgl1-mesa-glx

COPY .  .

# Exécutez votre script Python lorsque le conteneur démarre
CMD ["python", "/inference/TotalSegmentator.py"]
