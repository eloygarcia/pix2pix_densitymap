FROM continuumio/miniconda3 as conda

WORKDIR /app

# Make RUN commands use `bash --login`:
# SHELL ["/bin/bash", "--login", "-c"]


## OpenGL issue due to CV2
RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y

# create the environment
COPY environment2.yml  .
RUN conda env create -f environment2.yml

## MAKE ALL BELOW RUN COMMANDS USE THE NEW CONDA ENVIRONMENT
SHELL ["conda", "run", "-n", "pix2pix", "/bin/bash", "-c"]

# activate the enviroment
# RUN conda activate taming
RUN echo "conda activate pix2pix" >> ~/.bashrc
# SHELL ["/bin/bash", "--login", "-c"]
RUN echo "make sure it is installed"

# run pip
RUN pip install --upgrade pip
COPY pip_requirements.txt /app/

#RUN pip install tokenizers
#RUN pip install transformers
RUN pip install opencv-python
#RUN pip install --force-reinstall torch==1.12.1+cu113 --extra-index-url https://download.pytorch.org/whl/

RUN pip install -r /app/pip_requirements.txt

# COPY . /app/
