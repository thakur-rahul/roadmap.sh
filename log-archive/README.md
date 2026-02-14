https://roadmap.sh/projects/log-archive-tool

Log Archiver Tool
A simple Bash command-line tool to archive logs on a set schedule by compressing them into a .tar.gz file and storing them in a new directory. The tool also records the archive date/time and can send email notifications to the user.

✨ Features
Compresses logs into a .tar.gz archive.

Stores archives in a dedicated archives/ directory.

Logs archive creation date/time in archive_log.txt.

Sends email notifications to a specified recipient.

Easy to run from the command line.

📦 Requirements
Unix-based system (Linux, macOS).

tar command (usually pre-installed).

mail command for email notifications:

On Ubuntu/Debian:

sudo apt install mailutils
On CentOS/RHEL:

sudo yum install mailx
Configured mail transport (Postfix, Sendmail, or SMTP relay).

⚙️ Installation
Clone or copy the script:

git clone https://github.com/your-repo/log-archive.git
cd log-archive
Make the script executable:

chmod +x log-archive.sh

🚀 Usage
Run the tool with the log directory and recipient email:

./log-archive.sh <log-directory> <recipient-email>
Example:

./log-archive.sh /var/log admin@example.com
This will:

Create an archive in archives/logs_archive_<timestamp>.tar.gz

Record the archive in archives/archive_log.txt

Send an email notification to admin@example.com

📂 Output
Archive file: archives/logs_archive_<timestamp>.tar.gz

Log file: archives/archive_log.txt

Email notification: Sent to the specified recipient