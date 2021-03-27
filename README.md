# act-censorship
This repository contains a list of hostnames known to be blocked on ACT Fibernet's network.

## Methodology
The primary censorship technique employed by ACT Fibernet appears to poisons the DNS `A record` entry for each root domain present on their block list.

The poisoned `A record` so far appears to consistently point to a single static IP address (`49.205.171.200`) This knowledge is useful for querying a large list of hostnames for the purpose of inferring a proportionate list of blocked hostnames.

```
...
tencent.com. 0 IN A 49.205.171.200
qq.com. 0 IN A 49.205.171.200
ucweb.com. 0 IN A 49.205.171.200
...
```

## Data

As a uniform list of suitable hostnames was not readily available, several publicly available domain name lists were collated and used as input. The collated dataset was further modified to exclude subdomains and duplicate entries. The process used for excluding subdomains was not ideal, as a result of which a small portion of first level domains were accidentally omitted from the compiled list.

1. **Top 1 million from [Alexa](http://s3.amazonaws.com/alexa-static/top-1m.csv.zip)**

The version of the `top-1m.csv` list available as of today does not actually contain `1000000` lines. After Alexa officially discontinued the list, the actual number of domain names included in it appears to vary every day. At the time this list was pulled, `top-1m.csv` contained roughly `700000` lines.

2. **Top 10 million from [DomCop](https://www.domcop.com/files/top/top10milliondomains.csv.zip)**

This list was reduced to roughly `6000000` lines after subdomains and subsequent duplicate entries were removed from the list.

3. **Collections released by [Domains Project](https://dataset.domainsproject.org)**

```
.IN dataset [Pruned to 582582 entries]
.CO dataset [Pruned to 828814 entries]
.NET dataset [Pruned to 6326153 entries]
.ORG dataset [Pruned to 8625008 entries]
```

4. **List of potentially blocked hostnames by [Kushagra Singh](https://github.com/kush789/How-India-Censors-The-Web-Data/blob/master/potentially_blocked_unique_hostnames.txt)**

This list, released as part of the paper "How India Censors the Web" includes around `5000` 'potentially blocked' hostnames. The list was modified to include only first level domains.

### Results
Out of the hostnames queried, a total of `3592` individual hostnames [were found](https://github.com/qurbat/act-censorship/blob/main/compiled_block_list.txt) to have been censored.

### Source data
The lists made available by Alexa and DomCop contained more than half of the hostnames present in the final compiled block list despite their comparitive differences in their size. This can be attributed to the precondition of popularity around which the two lists are meant to be centered.

The lists made available by Domains Project were found to be extremely useful for uncovering hostnames that might be considered *"obscure"*.

The list made available as part of the data from the paper "How India Censors the Web" proved to be quite useful for discovering even more obscure hostnames that did not feature in the other lists.

**Note:** The list of blocked hostnames released here is not representative of all of the hostnames that might be blocked by ACT Fibernet at any given time.

### Reproducibility

#### act-blocktest.sh

```
./act-blocktest.sh compiled_block_list.txt
```

**Note:** The script expects a response of `IN A 49.205.171.200` for identifying blocked hosts. If you intend to run the script using the network of an Internet service provider other than ACT, you will have to modify the expected response for identifying a blocked host on [line 16](https://github.com/qurbat/act-censorship/blob/main/blocktest.sh#L16) accordingly.

#### MassDNS
[MassDNS](https://github.com/blechschmidt/massdns) can be used to query a sizeable number of hostnames with speed. The responses from these DNS queries can then be used to extraploate blocked hosts.

```
./massdns -r lists/act_resolver.txt -s 10000 -t A lists/10m_domain_sorted.txt > output/10m_dns_responses.txt
cat output/10m_dns_responses.txt | grep "POISONED_A_RECORD_HERE" > 10m_blocked.txt
```

### Notes

This repository was inspired by the paper *[How India Censors the Web](https://arxiv.org/abs/1912.08590)* authored by Kushagra Singh, Gurshabad Grover, and Varun Bansal. The primary intention behind this repository is to introduce some amount of transparency to the otherwise opaque processes associated with web censorship in India. It is hoped that this data will be useful to those researching the scale and impact of web censorship in India.
