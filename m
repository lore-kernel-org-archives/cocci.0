Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10ABD68BF2
	for <cocci@archiver.kernel.org>; Sun, 17 Nov 2024 09:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=uKzODPPrZCrncDXHV7lau4moh7PifewtZduxiiTzoKo=;
  b=bmwCJS4JMB5FgJTu7DmxC6qoG095FNmNO7X7WFZXsHhuR/5gfNHeMDAh
   ts0VkDNpsvgcwxPbfhgCV72dNjflX8+nBitaJQtcI2VlubE9cEjVcv/4E
   lFtjwfdv0ZL5OMncEBa9t6ET5YbBAFelBBYfI4AejOBiXPuk4GEKnFID5
   Y=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.12,161,1728943200"; 
   d="scan'208";a="194253976"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Nov 2024 10:27:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5F125E013D; Sun, 17 Nov 2024 10:27:21 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 40075E00B7
	for <cocci@sympa.inria.fr>; Sun, 17 Nov 2024 10:27:17 +0100 (CET)
IronPort-SDR: 6739b6e4_J1ZYjQM7ttT6A3lFfLwDUjrKYsgxK1NnD3RNCDF25fUqkKu
 +ypXp0kjH8qwecG3Fszj244fJlO+s0ZcsRUnang==
X-IPAS-Result: =?us-ascii?q?A0E6BQCUtjlngAwR49RagQmBU4JEYhtaMwQLSASEUo9Ng?=
 =?us-ascii?q?XSEa48RiHWBVhSBag8BAwENOwYBAgQBAQMENwGBVI1BAh4HAQQyBw4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOCjGFew2CW4EsgSYBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEdAg06bR0BAREnNAImAnECAQGCfQGCLwEDMQcNsHKBMoEBg?=
 =?us-ascii?q?gwBAQaCaNdzHywiV4FkAwaBGi6FaoJIGgEFbYoVD4FVRIE8gwOEYwVmgw6Ca?=
 =?us-ascii?q?YJFhRMliBdomhWBTRwDWTIBVRMXCwcFgXYDg0iBNoFRgxBKhQyBBYJKaUs3A?=
 =?us-ascii?q?g0CNoIkfYJPgSUEBYNshGyEXoQHHUACAQttPTUJCxsGPZ5ygRxHhG+BfZNdG?=
 =?us-ascii?q?JEfoTc0B4I4gWWBYwyJA4EklTIGEy+DcZNPDgaSeph3jAeBeJVShVaBbgYtg?=
 =?us-ascii?q?VwzGiSDNhM8AxkPkk6EYcESQjUCATgCBwsBAQMJhUYBAYlEgUsBAQ?=
IronPort-PHdr: A9a23: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
 D9hbwVSo7fW4S4K2p2X/kRe43AjIeTWw06k
IronPort-Data: A9a23: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
 YT4eIycfHyGdA==
IronPort-HdrOrdr: A9a23:K5bDmqicPppQq9/VSB1BVZwAQ3BQXvgji2hC6mlwRA09TyXqrb
 HMoB19726StN9xYgBFpTnkAsK9qBznmqKdjbNhX4tKPzOJhILLFu1fBOLZqlWMJ8SUzJ856U
 4PSchDIeHRSX5nkM39/A60KNo4xsKbmZrY/ds2g00NcelwAZsQiTuR5zzra3Gfz2R9b6YEKA
 ==
X-Talos-CUID: 9a23:+dMBrm2UkZlJFQ8UjNzY2rxfNZglf2fUj1npCGymOEFDWYbJWH+u9/Yx
X-Talos-MUID: 9a23:km32ywmhUyk8j6Ss9x34dno4OOZVoPW2AnoBvok8ocCKD3FbKiu02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,161,1728943200"; 
   d="scan'208";a="101823018"
X-MGA-submission: =?us-ascii?q?MDFJdqAQBnUrgUfftqRM/mfk4C4e0OO6Eqx/+r?=
 =?us-ascii?q?woyN6Z5dtStvsoXZgTJGr8YB+2FjbZaVljv1GTVYFB6a16ACPtTvPnk/?=
 =?us-ascii?q?EeQ0jQ4qJYbR4EV+C8zhxlqcaeDjWyyQVb3q9xcDyy9TBcOrL/CZBYUB?=
 =?us-ascii?q?MA7jlERWDpRjYTZ7gCkMK9Qw=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 10:27:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1731835619; x=1732440419; i=markus.elfring@web.de;
	bh=uKzODPPrZCrncDXHV7lau4moh7PifewtZduxiiTzoKo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oWBQffHhqjUry7XeSyPNTWJ0BoGac6M9cgXgJmNg3SJRMepGaqiXo+FA5fKWhZCJ
	 QiaXJIH4ABmXSM81ID17l1uA5IFoUEPxcjsq35HFuc1dOor8D2HtC3TLBsMhhaMrd
	 MUptCNcM9kfEDk48r4hQcsrxNAJzYqd/qTfLsduQhsZkxoJFF+cq0v1wuN/xBkPvo
	 h9RnRPSO1qrStL5pVx4Tka3rU1N2HSFkC+LJmtwwZH/HT9V1WsVXvla7RmOYx/don
	 eVGrLG8xwUYN5QFHKiGrTqQBsSll09wWJreONzhm9ccjqWQizztC1tOBXiXief7DU
	 7KhRpf9OLQCujemwHQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MActe-1t1Zzn258q-00EDo6 for
 <cocci@inria.fr>; Sun, 17 Nov 2024 10:26:59 +0100
Message-ID: <5231db6d-7d76-4be9-a82c-5224babf8e29@web.de>
Date: Sun, 17 Nov 2024 10:26:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:7hVminTyDDuxmYW3fHbTj7+RFbeVkjnQUTYFhNmrXP/bNRdpuBN
 d6MSmn8xBK/nrGa2FSS8Vt7aX56YRDlLGFXF6c3ue9Ewi8La22HYZxNcGiv1kC+X1ZLL7+x
 +GF14OydPXHYG8bsenpJ0Ivaeh5cdQTapHlDI+hc1KrnkXfjkUb7ORBWha+XjafsFXPszYa
 xB+LgwwpRWnBvd8NMNX2Q==
UI-OutboundReport: notjunk:1;M01:P0:CHihJdZEWFU=;V/75IzDGQM/paqTabenCY0prXyW
 A9IvB+Yp5QTV1G/GUIfyOSxzvu3dRHMIpCQKblddEdEtpOjGrH7JqWDop3TOLJM+8agOo+J9L
 gqXw4P/5TGLgQXDiReDMI7kyY3g+Bl68NQaHMKcBFiY411Gm92L4YQS6nVNHQAQ4h0rIh9Rsp
 csAnBrIak3mEbGMelSZSTKZRkQE6255B8o0TmacN7YGoHl+tWMIKMiygTkHkdipNCzKsSerhV
 FBSxJbZkh5Ym+7Ew0e5yBBxhsHjZQJjHuH9Ncg8bU/vlEJvxaaKx8VQCrXsikR/pvgmRQ4PMB
 zvtmc+kIpWgpfTXstc1eO/u2cVcjE3L1B2oV202SAfHNeZ+0f6NmfjQl6n4z626HT+HKVrauX
 UV31zxl3Q+e85cIfDX1uIRY/v2IDlt5YBdRYwdWj6JRKROLMM8PEIvyxm7zr0YVSANJlkUxFa
 1NBooTBqVxK7ULnp9NxASJ17S1dOhuYctan7q/dDCBS5WqzslKZwdvF/uqPvxORdB33fslIul
 oTYWDVmyx3ycCLBO6HkDzp91Lvq49NVKC1E8sIWpVQmLR70M/cI4nyw3/N34gVDqapocA0nTb
 YXvzjfPpHhFQz64kl4z/b6iRqbPTMPsU9wjMFxfb+KNVDvT2p5O9xV9bL+UGZmaQL8nfABhrF
 E/F2nw0y5b/J7A6N86KrSbthik7qf2+ORbSmUNynFxOHeAw9krUOU3lcBCxfVPhonug23HgjL
 EMS6hJBQba28LUAiGYO+81cqXlZh+Y5C9sEaDnaQ9QBhd8sCLR/1t9LrukgaER/GE2vV2VNUG
 D9yD/ddoIdkpZXPEtLmJtXiHuM7ifvnPvTtGyoi9LwIFLkEZpbKVnwKi42GJvB56TQ4VZFlU+
 Qh7Ub/llbc9Wtdw7geQ+3OoQXJ6y0GHY2lfNI+Li7u9zLMqzJcSgksu6A
Subject: [cocci] Reconsidering special return statements (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2074
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/5231db6d-7d76-4be9-a82c-5224babf8e29%40web.de>

Hello,

Another special statement combination was pointed out also by Nobuhiro Iwamatsu
for further software development considerations.

[PATCH v2] power: reset: as3722-poweroff: Remove unnecessary return in as3722_poweroff_probe
https://lore.kernel.org/linux-kernel/20241117053443.1148902-1-iwamatsu@nigauri.org/


Would you like to become able to handle such source code places also
by the means of the semantic patch language?

@display@
@@
*return ...;
*return ...;


Regards,
Markus
