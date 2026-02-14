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

### Q: Can the bot download files one by one from a folder, upload them, and delete them to save space?
**Answer:** **No.**
The bot is designed to download the entire task (whether it's a single file or a folder) *completely* before starting the upload process. It does not support streaming or pipelining files one by one. Therefore, the **total size of the task** (the sum of all files in a folder) must fit within the disk limit (approx. 500MB on Heroku).

## Summary of Bot Process & Limits on Heroku

### The Process (For non-Server-Side Copy tasks)
For direct downloads (Mega, direct links, torrents) and uploading to Telegram/Drive/Rclone:
1.  **Download:** The **entire** content of the link (file or folder) is downloaded to the bot's local storage.
2.  **Process:** (Optional) Extraction, zipping, or splitting happens on the local storage.
3.  **Upload:** The processed files are uploaded to the destination.
4.  **Clean:** The local files are deleted.

### The Limits
*   **Disk Limit:** Approximately **500MB** (Heroku Ephemeral Filesystem).
*   **Consequence:** Any task larger than 500MB involving local storage will fail ("Disk Full" error).

### Exceptions
*   **Google Drive Server-Side Copy (Clone):** Does *not* use local disk space. You can copy files larger than 500MB between Drives.
*   **Rclone Server-Side Copy:** Some Rclone remotes support server-side copy without downloading. Check Rclone documentation.

### Recommendation
For tasks exceeding 500MB (like 50-100GB Mega/Drive downloads), **use a VPS** (Virtual Private Server) with sufficient disk space (e.g., 200GB+ Storage). Heroku is not suitable for this specific high-storage use case.
