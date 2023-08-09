# Use the official Python image as the base image
FROM python:3.8 
# we will make ourself root user
USER root
# Create a directory named 'app' inside the container
RUN mkdir /app
# Copy the current directory contents into the '/app/' directory inside the container
COPY . /app/
# Set the working directory inside the container to '/app/'
WORKDIR /app/
RUN pip3 install -r requirements.txt

# Set environment variables for Apache Airflow configuration
#where airflow code will be there
ENV AIRFLOW_HOME="/app/airflow"  
ENV AIRFLOW__CORE__DAGBAG_IMPORT_TIMEOUT=1000
ENV AIRFLOW__CORE__ENABLE_XCOM_PICKLING=True

# Initialize the Airflow metadata database
RUN airflow db init 
#This creates an Airflow user with the provided email, first name, last name, password, role, and username
RUN airflow users create  -e avnish@ineuron.ai -f Avnish -l Yadav -p admin -r Admin  -u admin

# Make 'start.sh' script executable by changing its permissions
#This changes the permissions of the 'start.sh' script to make it executable.
RUN chmod 777 start.sh

#This installs the 'awscli' package using apt,
#allowing you to interact with AWS services from within the container.
# so that artifact and model we can store there
RUN apt update -y && apt install awscli -y

#This sets the entrypoint for the container to '/bin/sh'.
#The entrypoint defines the default command that will be executed when the container starts.
ENTRYPOINT [ "/bin/sh" ]

#This sets the default command to execute the 'start.sh' script when the container starts.
#The CMD instruction provides defaults for an executing container, 
#and it can be overridden when running the container
CMD ["start.sh"]

