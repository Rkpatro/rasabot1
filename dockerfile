# Base image for Rasa
FROM rasa/rasa:latest

# Copy Rasa project files
COPY . /app

# Install ngrok, configure, create tunnel
#RUN pip install --no-cache-dir -r /app/requirements.txt
RUN curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
	| sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null \
	&& echo "deb https://ngrok-agent.s3.amazonaws.com buster main" \
	| sudo tee /etc/apt/sources.list.d/ngrok.list \
	&& sudo apt update \
	&& sudo apt install ngrok
RUN ngrok config add-authtoken 2nnsrkPug42sxPqNEZzbQ4UVGjU_6LEUTCkNSjWrRgCNwfMw8
RUN ngrok tunnel --label edge=edghts_2nnsrkPug42sxPqNEZzbQ4UVGjU_6LEUTCkNSjWrRgCNwfMw8 http://localhost:5005	


# Set the entrypoint for the Rasa server
ENTRYPOINT ["rasa"]
