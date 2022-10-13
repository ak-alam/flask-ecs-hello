FROM python:3.8-slim
ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1
WORKDIR /src/app/
COPY . /src/app/
# RUN ls
RUN pip install -r requirement.txt
EXPOSE 5000
ENTRYPOINT [ "python" ]
CMD [ "app.py" ]
