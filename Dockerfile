FROM ubuntu:22.04

WORKDIR /app


COPY test_.py /app
COPY app.py /app
COPY templates /app/templates

RUN apt-get update && apt-get install -y curl python3 python3-pip
RUN pip3 install Flask,pytest

RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
RUN chmod a+x /usr/local/bin/yt-dlp

EXPOSE 5000
ENTRYPOINT ["python3", "app.py"]