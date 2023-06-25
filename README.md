# blocked-hosts
[![Statistics](https://img.shields.io/badge/sites-6,086-brightgreen)](https://github.com/qurbat/blocked-hosts)
![GitHub last commit](https://img.shields.io/github/last-commit/qurbat/blocked-hosts?color=blue)

This repository houses a periodically updated list of websites (first-level domains only) that are known to be blocked on the ACT Fibernet network. A current list of hostnames blocked by ACT Fibernet can be found [here](https://github.com/qurbat/blocked-hosts/blob/main/compiled_block_list.txt). Historic results are available in the `output` directory.

**Update 25-06-2023:** A list of websites blocked by Hathway Broadband can be found [here](https://github.com/qurbat/blocked-hosts/blob/main/compiled_block_list.txt). The DNS resolvers for Hathway Broadband have also been added to the `resources` folder. Support for checking websites blocked by Hathway Broadband will be added soon.


**Note:** The list(s) published here are not fully representative of all hostnames that might be blocked by ACT Fibernet at a given time.

| date of test      | total hosts  | removed since last test    | added since last test            |
|-------------------|--------------|----------------------------|----------------------------------|
| June 3, 2023      | 6,086        | 32 hosts removed           | 137 hosts added                  |
| February 13, 2023 | 5,981        | -                          | 547 hosts added                  |
| January 26, 2023  | 5,434        | 96 hosts removed           | 128 hosts added                  |
| May 26, 2022      | 5,402        | 87 hosts removed           | 33 hosts added                   |
| November 22, 2021 | 5,456        | 1 host removed             | 1176 hosts added                 |
| July 28, 2021     | 4,281        | -                          | 231 hosts added                  |
| June 8, 2021      | 4,050        | -                          | 555 hosts added                  |
| April 16, 2021    | 3,495        | 179 hosts removed          | 76 hosts added                   |
| March 28, 2021    | 3,593        | -                          | 3593 hosts added                 |

## Method
The primary web censorship technique employed by ACT Fibernet is of poisoning the DNS `A record` entry for the root domain of a blocked host.

```
tencent.com. 0 IN A 202.83.21.14
qq.com. 0 IN A 202.83.21.14
ucweb.com. 0 IN A 202.83.21.14
```

The poisoned `A record` entry has been documented to consistently point to only a few IP addresses. This characteristic enables fingerprinting blocked hostnames.

## Data

As a uniform list of suitable hostnames was not readily available, several publicly available domain name lists were collated and used as input. The collated list was further modified to exclude subdomains and duplicate entries.

1. **Top 1 million from [Alexa](http://s3.amazonaws.com/alexa-static/top-1m.csv.zip)**

2. **Top 10 million from [DomCop](https://www.domcop.com/files/top/top10milliondomains.csv.zip)**

3. **Collections released by [Domains Project](https://dataset.domainsproject.org)**

4. **List from [How India Censors the Web](https://github.com/kush789/How-India-Censors-The-Web-Data/blob/master/potentially_blocked_unique_hostnames.txt)**

5. **List from Citizen Lab's [reposistory](https://github.com/citizenlab/test-lists)**

## Installation
The `install.sh` script can be used to install the `tldextract` package using `pip`, and to download, compile, and install the `massdns` binary from source.

**Note:** `python3` is required to already be installed on your system.

## Usage

```
./run.sh <input_list.txt>
```

If you intend to run the script using the network of an Internet service provider other than ACT Fibernet, you will have to modify the variable defined on [line 4](https://github.com/qurbat/act-censorship/blob/main/run.sh#L4) for identifying a blocked host.

The `run.sh` script makes use of [massdns](https://github.com/blechschmidt/massdns) to query a sizeable number of hostnames with speed, the responses of which are used for extraploating blocked hostnames. The `apex.py` script extracts root-level hostnames from the results with the help of the `tldextract` package. The list of root-level hostnames is then de-duplicated and saved to disk.

## Verification
The `test.sh` script can be used to verify the latest provided block list. This script guarantees accuracy over speed and is not bandwidth intensive, unlike `run.sh`.

## Notes
This repository builds on the paper [How India Censors the Web](https://arxiv.org/abs/1912.08590) authored by Kushagra Singh, Gurshabad Grover, and Varun Bansal. The primary intention behind this repository is to introduce some amount of transparency to the otherwise opaque processes associated with web censorship in India.

The [captn3m0/airtel-blocked-hosts](https://github.com/captn3m0/airtel-blocked-hosts) repository provides a similar list of hostnames known to be blocked on the Airtel Broadband network.
