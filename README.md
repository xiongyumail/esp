# _ESP_

## Contents

    * tools

      * esp-idf sdk

## How to use

You can follow the steps below to set up the development environment, or directly download the release version of the full environment.

* docker.io

  ```
  sudo apt install docker.io
  ```

* clone

  ```bash
  git clone --recursive https://github.com/xiongyumail/esp
  cd esp
  ```

  * note

    Don't omit `--recursive`, because we use submodule.

* update

  ```bash
  git pull
  git submodule update --recursive
  ```

* Run

  ```bash
  cd [your_projects_path]
  ./../esp/start.sh .
  ```

