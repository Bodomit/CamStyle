FROM pytorch/pytorch:0.4.1-cuda9-cudnn7-devel

# Make the directories in root.
RUN mkdir /src

# Copy requirements file to the src dir.
WORKDIR /src
COPY CycleGAN-for-CamStyle/requirements.txt /src

# Install pip modules
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy the rest of the code.
COPY . /src

# Set docker env variables.
ENV ROOT_DATASET_DIR=/datasets
ENV RESULTS_DIR=/results

# Default to training the market.
WORKDIR /src/CycleGAN-for-CamStyle
CMD ./test_market.sh