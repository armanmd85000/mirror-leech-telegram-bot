# Deploying to Heroku

This repository is configured for deployment on Heroku using Docker.

## Prerequisites

1.  A Heroku account.
2.  Heroku CLI installed.
3.  Docker installed.

## Deployment Steps

1.  **Clone the repository:**
    ```bash
    git clone <your-repo-url>
    cd mirror-leech-telegram-bot
    ```

2.  **Login to Heroku:**
    ```bash
    heroku login
    heroku container:login
    ```

3.  **Create a Heroku App:**
    ```bash
    heroku create <app-name>
    ```

4.  **Set Environment Variables:**
    Set the required environment variables using the Heroku Dashboard or CLI.
    ```bash
    heroku config:set BOT_TOKEN="your_bot_token"
    heroku config:set OWNER_ID="your_telegram_id"
    heroku config:set TELEGRAM_API="your_api_id"
    heroku config:set TELEGRAM_HASH="your_api_hash"
    # Add other optional variables as needed (e.g., GDRIVE_ID, DATABASE_URL)
    ```

5.  **Deploy:**
    ```bash
    heroku container:push web
    heroku container:release web
    ```

6.  **Open the App:**
    ```bash
    heroku open
    ```
    (Note: The app is a Telegram bot, so interaction is via Telegram, but opening the app ensures it's running).

## Important Notes on File Downloads (Google Drive & Mega)

### Q: Can I download 50-100GB Google Drive files with this bot on Heroku?
**Answer:** It depends.
-   **Server-Side Copy (Drive to Drive):** Yes, if you are copying files from one Google Drive to another (Cloning), the bot can handle it because the data doesn't pass through the bot's disk.
-   **Download to Bot:** No. If you try to download the file to the bot (e.g., to upload to Telegram or another cloud that requires intermediate storage), it will fail because Heroku dynos have a **disk limit of approximately 500MB**. A 50-100GB file will instantly fill the disk and crash the bot.

### Q: Can I download 50-100GB Mega files with this bot on Heroku?
**Answer:** **No.**
Downloading from Mega.nz requires downloading the file to the local disk first before uploading it to the destination (Google Drive or Telegram). Due to Heroku's 500MB disk limit, downloading a 50-100GB file is impossible on Heroku.

### Solution for Large Files
To handle large files (50-100GB) from Mega or for non-server-side Google Drive transfers, you must deploy this bot on a **VPS** (Virtual Private Server) with sufficient disk space (e.g., 200GB+ Storage). Heroku is not suitable for this specific high-storage use case.
