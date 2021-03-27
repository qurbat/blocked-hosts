# act-censorship
This repository contains a list of hostnames known to be blocked on ACT Fibernet's network.

## Methodology
The primary censorship technique employed by ACT Fibernet appears to poisons the DNS `A record` entry for each root domain present on their block list. The poisoned `A record` further appears to consistently point to a static IP address (`49.205.171.200`) This knowledge becomes useful when enumerating a large set of hostnames with the purpose of inferring a proportionate list of blocked hostnames.

```
...
tencent.com. 0 IN A 49.205.171.200
qq.com. 0 IN A 49.205.171.200
ucweb.com. 0 IN A 49.205.171.200
...
```

## Data

As a uniform list of suitable root domains was not readily available, several publicly available domain name sets were collated and used as input. The collated dataset was modified to exclude subdomains as well as any duplicate entries. The process used for excluding subdomains was not ideal, as a result of which a number of root domain names were accidentally omitted, too.

1. **Top 1 million from [Alexa](http://s3.amazonaws.com/alexa-static/top-1m.csv.zip)**

The version of the `top-1m.csv` list available as of today does not actually contain `1000000` lines. After support for the list was officially discontinued, the actual number of domain names included in it varies on any given day. At the time this list was pulled it contained roughly 700,000 lines.

2. **Top 10 million from [DomCop](https://www.domcop.com/files/top/top10milliondomains.csv.zip)**

This list was reduced to roughly 6,000,000 lines after subdomains and subsequent duplicate entries were pruned from the list.

3. **Collections released by [Domains Project](https://dataset.domainsproject.org)**

```
.IN dataset [Pruned to 582582 entries]
.CO dataset [Pruned to 828814 entries]
.NET dataset [Pruned to 6326153 entries]
.ORG dataset [Pruned to 8625008 entries]
```

4. **List of potentially blocked hostnames by [Kushagra Singh](https://github.com/kush789/How-India-Censors-The-Web-Data/blob/master/potentially_blocked_unique_hostnames.txt)**

### Results
Out of the hostnames queried, a total of `3592` individual hostnames [were found](https://github.com/qurbat/act-censorship/blob/main/compiled_block_list.txt) to have been blocked.

#### Datasets
Despite their comparatively smaller sizes, the lists made available by Alexa and DomCop contained more than half of the hostnames present in the final compiled block list. This observation can likely be attributed to the precondition of popularity around which the lists are meant to have been centered. The lists made available by Domains Project were found to be extremely useful for uncovering otherwise *"obscure"* blocked hostnames. The dataset made available as part of the paper "How India Censors the Web" proved to be quite useful for extracting blocked hostnames that did not feature in the other lists.

**Note:** The list of blocked hostnames released here is neither definitive nor fully representative of all hostnames that might be blocked by ACT Fibernet at any given time.

### Reproducibility

#### act-blocktest.sh

```
./act-blocktest.sh compiled_block_list.txt
```

**Note:** The script expects a response of `IN A 49.205.171.200` to identify a blocked host. If you intend to run the script using the network of a service provider other than ACT, you will have to modify the expected response for identifying a blocked host on [Line 16](https://github.com/qurbat/act-censorship/blob/main/blocktest.sh#L16) accordingly.

#### MassDNS
[MassDNS](https://github.com/blechschmidt/massdns) can be used to query a sizeable number of hostnames with speed. The responses from these DNS queries can then be used to extraploate blocked hosts.

```
./massdns -r lists/act_resolver.txt -s 10000 -t A lists/10m_domain_sorted.txt > output/10m_dns_responses.txt
cat output/10m_dns_responses.txt | grep "POISONED_A_RECORD_HERE" > 10m_blocked.txt
```

### Notes

This repository was inspired by the paper *[How India Censors the Web](https://arxiv.org/abs/1912.08590)* authored by Kushagra Singh, Gurshabad Grover, and Varun Bansal. The primary intention behind the repository is to introduce some amount of transparency to the otherwise opaque process of web censorship followed by telecommunications and Internet service providers in India.

It is hoped that this data will be useful to those researching the scale and impact of web censorship in India.
