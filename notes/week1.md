# Week 1: Introduction & Prerequisites
## Introduction
* [Video](https://www.youtube.com/watch?v=bkJZDmreIpA&t=37s)
* This zoomcamp is intended for people who do not understand data engineering. So the instructors will teach us everything from the basic
* The instructors:
  * [Ankush Khanna](https://linkedin.com/in/ankushkhanna2)
  * [Sejal Vaidya](https://linkedin.com/in/vaidyasejal)
  * [Victoria Perez Mola](https://www.linkedin.com/in/victoriaperezmola/)
  * [Alexey Grigorev](https://linkedin.com/in/agrigorev)
* Throughout the zoomcamp, we will build this architecture:
![alt text](https://github.com/DataTalksClub/data-engineering-zoomcamp/blob/main/images/architecture/arch_1.jpg?raw=true)
* The technologies we will use throughout zoomcamp:
  * Google Cloud Platform (GCP): Cloud-based auto-scaling platform by Google
    * Google Cloud Storage (GCS): Data Lake
    * BigQuery: Data Warehouse
  * Terraform: Infrastructure-as-Code (IaC)
  * Docker: Containerization
  * SQL: Data Analysis & Exploration
  * Airflow: Pipeline Orchestration
  * DBT: Data Transformation
  * Spark: Distributed Processing
  * Kafka: Streaming 
## Docker
* [Video](https://www.youtube.com/watch?v=EYNwNlOrpr0&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb&index=3)
* [Docker](https://en.wikipedia.org/wiki/Docker_(software)) is a service that deliver software (or in this case is data pipeline) in packages called containers. Containers are isolated one another and bundle their own software, libraries, and configuration files. Eventhough containers isolated one another, they still can communicate each other so you can run multiple containers without conflict
* Docker can reproduce from Docker Image. Docker Image is a set of instructions and setup to build containers that saved in 'image'. From this image we can produce multiple identical containers.
* Advantages of docker:
  * Reproducibility
  * Local experimentation
  * Integration tests (CI/CD)
  * Running data pipelines on the cloud (AWS Batch, Kubernetes jobs)
  * Spark (analytics engine for large-scale data processing)
  * Serverless (AWS Lambda, Google functions)
* You can install docker [here](https://docs.docker.com/get-docker/)
### Create Data Pipeline in Containers
* [Codes]()
* Create a dummy data pipeline named `pipeline.py` with python

```python
import sys
import pandas #we won't use pandas, this is just for example

print(sys.argv)
day = sys.argv[1]

print(f'job finished succesfully for day: {day}')
```

  * `sys.argv` is used to pass list of command line arguments. In this case we want to run the data pipeline in particular date so we pass list of date as the arguments
  * `sys.argv[0]` is the name of the current python script. `sys.argv[1]` contains the first argument that passed

* Create dockerfile named `Dockerfile` to build docker image

```dockerfile
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
```

* Build docker image

```bash
$ docker build -t test:pandas .
```
  * `test:pandas` means our image's name is `test` and it has `pandas` tag. If we don't insert the tag, it will become `test:latest`
  * `.` means our dockerfile in the current directory

* Run our container from the image

```bash
$ docker run -it test:pandas 01-21-2022
```
  * `-it` means we run in interactive terminal
  * `01-21-2022` is the argument that passed to `argv`

* The output should be:

```
['pipeline.py', '01-21-2022']
job finished succesfully for day: 01-21-2022
```
