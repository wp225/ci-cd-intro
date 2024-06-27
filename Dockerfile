FROM ubuntu:22.04

WORKDIR /app

COPY requirements.txt /app

COPY test_.py /app
COPY app.py /app
COPY templates /app/templates

RUN apt-get update && apt-get install -y curl python3 python3-pip
RUN pip3 install -r requirements.txt

RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
RUN chmod a+x /usr/local/bin/yt-dlp

EXPOSE 5000
CMD ["python3", "app.py","pytest"]