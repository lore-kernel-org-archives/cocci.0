From: michael.j.ruhl@intel.com (Ruhl, Michael J)
Date: Mon, 8 May 2017 21:12:59 +0000
Subject: [Cocci] 773 777 coccicheck failed
Message-ID: <14063C7AD467DE4B82DEDB5C278E866375E7EF27@FMSMSX108.amr.corp.intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I am using the coccicheck feature of the latest Linux kernel (4.11.0-rc6) and I am getting the following failure:

773 777 coccicheck failed

When I run this:

% export COCCI=scripts/coccinelle/misc/boolconv.cocci
% make coccicheck MODE=report M=drivers/infiniband/hw/hfi1 V=1 J=1

(the actual driver does not appear to be an issue, I tested with several and they have all failed)

This is the only .cocci test that is failing.

I was wondering if you could give me some insight as to what this failure might be?

Thanks,

Mike

spatch --version
spatch version 1.0.4 with Python support and with PCRE support
