# Directus backup scripts

This repository contains scripts to backup and restore [Directus-prod](https://github.com/digital-botanical-gardens-initiative/Directus-prod) instance.

## Prerequisites

Having a running Directus instance

## Setup

### 1. Clone the repository to your local machine:

```bash
git clone https://github.com/digital-botanical-gardens-initiative/directus-backup.git
cd directus-backup
```

### 2. Create a .env file in the root folder and edit it to suit your needs:
```bash
cp .env.example .env
vim .env
```

### 3. Run scripts manually:

- Making short term backups:

```sh
/directus_bckp_short_term_script.sh
```

- Making long term backups:

```sh
/directus_bckp_long_term_script.sh
```

- Restoring a backup:

```sh
/directus_restore_script.sh </path/to/backup/folder> <backup timestamp in format YYYYMMDDHHMMSS>
```


### 4. Run scripts in cronjob (only backups):

- Open cronjobs file:

```sh
crontab -e
```

- Add cronjobs:

For example to run the short term backups every 2 hours: 
```sh
0 */2 * * * /path/to/short/term/script/directus_bckp_short_term_script.sh
```

For example to run the long term backups every sunday at 1 AM:
```sh
0 1 * * 0 /path/to/long/term/script/directus_bckp_long_term_script.sh
```

## Contributing

If you would like to contribute to this project or report issues, please follow our contribution guidelines.

## License

see [LICENSE](https://github.com/digital-botanical-gardens-initiative/directus-backup/blob/main/LICENSE) for details.