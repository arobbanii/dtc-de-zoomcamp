# we will use python 3.9 as our base image
FROM python:3.9

# install modules before running the script
# I use --default-timeout=1000 to extend the timeout because my internet connection is poor
RUN apt-get install wget
RUN pip --default-timeout=10000 install pandas sqlalchemy psycopg2

# this is the working directory inside container
WORKDIR /app
# copy python file from our local host to container
COPY ingest_data.py ingest_data.py 

# this is the first thing container do when runs. in this case container just runs the python script
ENTRYPOINT [ "python", "ingest_data.py" ]
