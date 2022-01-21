# we will use python 3.9 as our base image
FROM python:3.9

# install pandas before running the script
# I use --default-timeout=1000 to extend the timeout because my internet connection is poor
RUN pip --default-timeout=1000 install pandas
# this is the working directory inside container
WORKDIR /app
# copy python file from our local host to container
COPY pipeline.py pipeline.py

# this is the first thing container do when runs. in this case container just runs the script
ENTRYPOINT [ "python", "pipeline.py" ]