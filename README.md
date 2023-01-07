# blocked-hosts
[![Statistics](https://img.shields.io/badge/sites-5,530-brightgreen)](https://github.com/qurbat/blocked-hosts)
![GitHub last commit](https://img.shields.io/github/last-commit/qurbat/blocked-hosts?color=blue)

This repository houses a periodically updated list of websites (first-level domains only) that are known to be blocked on ACT Fibernet's network. A current list of blocked hostnames can be found [here](https://github.com/qurbat/blocked-hosts/blob/main/compiled_block_list.txt). Historic results are available in the `output` directory.

**Note:** The lists published here are not fully representative of all hostnames that might be blocked by ACT Fibernet at a given time.

| date of test      | total hosts  | removed since last test    | added since last test            |
|-------------------|--------------|----------------------------|----------------------------------|
| January 7, 2023   | 5,530        | -                          | 128 hosts added                  |
| May 26, 2022      | 5,402        | 87 hosts removed           | 33 hosts added                   |
| November 22, 2021 | 5,456        | 1 host removed             | 1176 hosts added                 |
| July 28, 2021     | 4,281        | -                          | 231 hosts added                  |
| June 8, 2021      | 4,050        | -                          | 555 hosts added                  |
| April 16, 2021    | 3,495        | 179 hosts removed          | 76 hosts added                   |
| March 28, 2021    | 3,593        | -                          | 3593 hosts added                 |

## Data

As a uniform list of suitable hostnames was not readily available, several publicly available domain name lists were collated and used as input. The collated list was further modified to exclude subdomains and duplicate entries.

1. **Top 1 million from [Alexa](http://s3.amazonaws.com/alexa-static/top-1m.csv.zip)**

2. **Top 10 million from [DomCop](https://www.domcop.com/files/top/top10milliondomains.csv.zip)**

3. **Collections released by [Domains Project](https://dataset.domainsproject.org)**

4. **List from [How India Censors the Web](https://github.com/kush789/How-India-Censors-The-Web-Data/blob/master/potentially_blocked_unique_hostnames.txt)**

5. **List from Citizen Lab's [reposistory](https://github.com/citizenlab/test-lists)**

The method used for extracting first level domains was not ideal, due to which a small portion of hostnames were omitted from the compiled input list. 

## Methodology
One of the web censorship techniques employed by ACT Fibernet is that of poisoning the DNS `A record` entry for each root domain present on their block list.

```
tencent.com. 0 IN A 202.83.21.14
qq.com. 0 IN A 202.83.21.14
ucweb.com. 0 IN A 202.83.21.14
```

The poisoned entries appear to consistently point to a single IP address for a period of at least a few weeks. This characteristic enables fingerprinting of blocked hostnames, and is used for querying a large list of hostnames in order to deduce a proportionate list of blocked hostnames.

## Reproducibility

ACT Fibernet users can verify a list of blocked hostnames by using the `blocktest.sh` script provided in this repository. The script provided in the repository expects a response of `IN A 202.83.21.14` to identify a blocked host.

```
./blocktest.sh output/<list.txt>
```

If you intend to run the script using the network of an Internet service provider other than ACT Fibernet, you will have to modify the expected response for identifying a blocked host on [line 16](https://github.com/qurbat/act-censorship/blob/main/blocktest.sh#L16) accordingly.

[MassDNS](https://github.com/blechschmidt/massdns) can be used to query a sizeable number of hostnames with speed. The responses from these DNS queries can then be used to extraploate blocked hosts.

```
./massdns -r resources/resolver.txt -s 500 -t A input.txt > output.txt
cat output/massdns_query_results.txt | grep "<POISONED_A_RECORD_IP>" > results.txt
```

## Notes

This repository builds on the paper [How India Censors the Web](https://arxiv.org/abs/1912.08590) authored by Kushagra Singh, Gurshabad Grover, and Varun Bansal. The primary intention behind this repository is to introduce some amount of transparency to the otherwise opaque processes associated with web censorship in India
