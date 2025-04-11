FROM public.ecr.aws/lambda/python:3.9
WORKDIR /app
COPY model.py /app/
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
RUN chmod +x model.py
CMD ["model.lambda_handler"]
