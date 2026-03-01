source mltbenv/bin/activate

if [ -n "$PORT" ]; then
    export BASE_URL_PORT=$PORT
fi

python3 update.py
python3 -m bot
