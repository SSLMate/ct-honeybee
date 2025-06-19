# Certificate Transparency Honeybee

The Certificate Transparency Honeybee (ct-honeybee) is a lightweight program that retrieves signed tree heads (STHs) from Certificate Transparency logs and uploads them to auditors.

You can help uphold the integrity of the Certificate Transparency ecosystem by running ct-honeybee on your workstation/server/toaster every hour or so (pick a random minute so that not everyone runs ct-honeybee at the same time).  Running ct-honeybee from many different Internet vantage points increases the likelihood of detecting a misbehaving log which has presented a different view of the log to different clients.


## Installation

Python 3 is required.

Install ct-honeybee and put it in a cron job to run once an hour or so (pick a random minute so that not everyone runs ct-honeybee at the same time).

ct-honeybee is stateless and won't write to your filesystem.


## Logs

ct-honeybee retrieves the list of logs from `loglist.certspotter.org`, which is operated by SSLMate.  At a minimum, the log list contains every log that is considered Qualified, Usable, or ReadOnly by Chrome or Apple.  ct-honeybee supports both RFC6962 and static-ct-api logs.


## Auditors

ct-honeybee uploads STHs to the following auditors:

 * `certspotter.com` (operated by SSLMate)

If you run an auditor that implements the sth-pollination endpoint described in Section 8.2 of draft-ietf-trans-gossip-00, please get in touch at <sslmate@sslmate.com> and we will add you to ct-honeybee.


## Technical Operation

1. Retrieve the log list.

2. For each RFC6962 log: fetch the latest STH and add it to the list of STHs.  For simplicity, signatures are not checked; we leave this job to the auditors.

3. For each static-ct-api log: fetch the latest checkpoint, convert it to an RFC6962 STH, and add it to the list of STHs.  For simplicity, signatures are not checked; we leave this job to the auditors.

4. Shuffle the list of auditors.

5. For each auditor: upload the list of STHs to the auditor using the protocol described in Section 8.2 of draft-ietf-trans-gossip-00.  Add each returned STH to the list of STHs so they get pollinated to subsequent auditors.  Since we shuffle the list of auditors, we will pollinate in a different order each time ct-honeybee is run.


## Legalese

Written in 2017-2025 by Opsmate, Inc. d/b/a SSLMate <sslmate@sslmate.com>

To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to this software to the public domain worldwide. This software is distributed without any warranty.

You should have received a copy of the CC0 Public Domain Dedication along with this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
