Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F554C433F5
	for <cocci@archiver.kernel.org>; Sat, 19 Mar 2022 19:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Sl+0M89HM/BHKUDp3s03QEaeiv2SjdMlXq76SAwEUG8=;
  b=YhB7NAzferKikgeh7lpCtLXd7F4NTu1E6YgKzwLGaXuZQMnyct4vjLDk
   jF1wMCsVFFY35E0pTDnBWFes6u8wuE6luSaWBd4xeYw8C78kDLIFN09/s
   h3TgmYsPK0I8QRN6pjn8JMiEkfr7jRri5V5YJJlnYVpYk9QCldthDYDGh
   E=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="5.90,195,1643670000"; 
   d="scan'208";a="27020694"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2022 20:10:15 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 83B33E0210; Sat, 19 Mar 2022 20:10:14 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CDC07E0069
	for <cocci@sympa.inria.fr>; Sat, 19 Mar 2022 20:10:13 +0100 (CET)
IronPort-SDR: KTS2QTraSKtLWY3CMbGnIS8axeOOvIIfdy1//lnQBAKi/fvF9UzNOo9o4AKxAKQSTJfWMHUtvJ
 nt8r7Ev3vPgjguyw8OdrFksgQ66WCcT4yttp4X4xDsaXQzX0RJYtqKuCO+O+qjYsWL40EQXEfj
 W6+8rKN8CSVBDaBIehhauI/ZVgPtbl5XnKLcjPSB1SyKA8FGhkEu0kD19qw1bamrDC+iz/TbNj
 Nz3Hd+m+d8z4AkeEoV8ODCpTuENim8fsTl4Gl8SJshE2u8dP0YRP5AsceCaEK0bW+eaByTU10F
 86lDHBjJL99CQD9lzNHrwIlV
X-IPAS-Result: =?us-ascii?q?A0DSBABQKTZi/0Xcza1agQmBWoIAKAeBTQEBASkEC5QLh?=
 =?us-ascii?q?U6ZPYF8CwEDAQ1BBAEBiT0CHQYGMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBA?=
 =?us-ascii?q?QECAQECBAQBgQgsAWMBZwGBTgGBeQYEPYI1IoQshRSDF617gTOBAYl7gTyOc?=
 =?us-ascii?q?BxAgU2BPIhThRAiBJgIgQITAYEcggaiFp4Wg1OfXhoulkmRdZZbpwKBPyI8g?=
 =?us-ascii?q?VkfFBoIJgqDJU0BAgECAQwBAgIBAgECAQIBCAEBAgGNdAGBTQEIjUEhAQEBa?=
 =?us-ascii?q?QIGCwEBAwmPTgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:vrq+Wqk9iL5Iz+NO1LAzL8bo5gyiIERdPkR7XQ2eYbSJt1+Wr1Gzt
 xJOWmuEPPfcNDH1eIxza4m39EkC68TXytFqGQc6pChgHltH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvykTres1hlZHWeIcg944f5Ys7N/09YAbeSRWVvX4
 4up+pyHYzdJ5hYtWo4qw/LbwP9QlK+q0N8olgRWiSdj4TcyP1FMZH4uDfnZw0nQGuG4LcbmL
 wr394xVy0uCl/sb5nxJpZ6gGqECaua60QFjERO6UYD66vRJjnRaPqrWqJPwZG8P4whlkeydx
 /1Jq8K+VD0EI5bRgdsRQUBUCxNsOIx/reqvzXiX6aR/zmXDYz3h3PVjAUU7J8se9/of7WNmr
 KNDbmpVM1bZ3brwnuPTpupE3qzPKOHgO4gUu1lkzCrFFrArXpDOTqHH/5le0StYasVmR6mGP
 ZJHOGEHgBLoXzRWJmgLOLgHpua6v37iIgZdoWixuv9ii4TU5FctjuO8b4q9lsaxbc5SlU2Zj
 nnX+nzwRBAcLt2WjzSfmk9AncfKjWX2R4IfGbm17LhsjUH7KnEv5AM+UUXlr+SDp1OFRstgJ
 15N9jIcv60TzRn+JjXiZCGQrHmBtx8aftNfFewm9Q2AopbpDxal6nssFWEeNYR33CMibXl7i
 Q/TxoKB6SlH6eXNERqgGqGoQSRe0BX5wEcHdWkJUgsI7t3uusc1gw6nojdf/Eyd1Y2d9dLYm
 WziQM0Ca1M715ZjO0KTpA6vvt5UjsKVJjPZHy2ONo9lhysgDGJfW6Sm6ELA8dFLJ5uDQ1+Ks
 RAswpbCs71QVcDcz3zWEY3h+Y1FAd7ebFUwZnY0QPEcG8mFoSP9FWyuyG4WyLhV3jYsImO3O
 x6M6Wu9FbdeI3unYKt6eYO3AIFylMDd+SfNDZjpgxsnSsYZSTJrCwk1PB/OhT+xyBZw+Uz9U
 L/CGfuR4b8hIfwP5FKLqy01iNfHHwgymjHeQ47V1ROi3ebMbXKZU+5VYl+Pdfwiqq6boAjY9
 9tFcc2H10wHAuH5ZyDW968VLEwLdCJnXsqu9pULL+PTcBB7HGwBCuPKxe1zcYJSn5NKyrXC8
 Ea7VxIK01H4n3DGdFuHMygxdLP1UJ9jhnsnJihwb02w0n0ubN/3vqcSfpc6Z5c98+lnwaImR
 vUJYZzQUPBOUSjcvTkCbZTwqIF4MhKmmVvWbSaiZTE+eb9mRhDIo4W4JVG3qXBSVyfu7Jkwu
 byt0A/fUKEvfQU6AZaEcu+rwnOwoWMZxrB4UXzIFcYPKk/ix45ndn7qhfgtLsBRdxianmmG1
 xybCAszrPXWp9Nn68HAgK2Jotv7E+Z6GUYGTWDX4azvaHvf7iyu3o9NXeKFZ3bbWX+toPeuY
 uBczvfdNvwbnQ8Q79EmS+sykfszt4n1urtX7gV4B3GVPV6lPbNXPSXU18d4sKAQlKRSvhG7W
 x/R94ACa6mJIs7sDHUYOBEhMraYzfgRlzSOv+45Jl72uH1+8LadCBgAOgnKhTNdIbZxPZljx
 +o94ZZE5wu6gxssE9CHkiENrTjXdCRdCvl+u8FIGpLvhyoq1kpGP87WBBj2147TOd9CBU8nf
 22Pj63YirUBmEebKygvFWLA1PZ2jIgVvEwY10cLIlmEl7IpXBPsMMG9Jdj2cuhU8vmD++djf
 GV0N0B4IaiUuTFlmKCvmoxq9x5pXHWkFo7ZkjPlV1E1i2GsV3fRNyswJuaA8UQU6SRacyQzE
 HR0Dor6eW6CQSwytxfenWZhquf/Vpp86Q3PlcSqBYKDEoVSjf8JREOxTTJgliYLyv/dSKEKS
 SeGMQqwhWDG2fYsnpAG
IronPort-HdrOrdr: A9a23:je0jxa4ApjgnB2IDoQPXwNjXdLJyesId70hD6qkRc20wTiT7//
 rAoB1173HJYVoqOU3I+urwXZVoI0msl6KdiLN5VdzOMDUO01HYT72Kg7GD/9Q+IUfDytI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,195,1643670000"; 
   d="scan'208";a="27020693"
X-MGA-submission: =?us-ascii?q?MDFxq6aIr1tgCCS80HU1+q/lK22pobcVJ7YxqB?=
 =?us-ascii?q?aqveF5PMI0pIQk7mb2etU8Pwikf1iAfjqzkMHT2O317S3ZQ1IV065MPs?=
 =?us-ascii?q?i16OAOr55urX9bcRxxrUgOrj9mj1xNr6xSi9cvgtrtAweNSA8gDah/g9?=
 =?us-ascii?q?hiWNhbn1CmPARmWWfkcKCYfA=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 20:10:12 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 834D481
	for <cocci@inria.fr>; Sat, 19 Mar 2022 12:10:10 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id XIyP42a4o1mV for <cocci@inria.fr>;
	Sat, 19 Mar 2022 12:10:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id A61C840
	for <cocci@inria.fr>; Sat, 19 Mar 2022 12:10:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net A61C840
Date: Sat, 19 Mar 2022 12:10:07 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: cocci@inria.fr
Message-ID: <a9b43b8f-7f87-5e55-fa98-cfd888848b7@ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [cocci] Using `parallel` to run over lots of .c files and avoiding
 stack overflows.
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 252
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/a9b43b8f-7f87-5e55-fa98-cfd888848b7%40ewheeler.net>

Hi All,

Just a quick tip for others (like me) who are new to Coccinelle:

You might already use this, but if not, here's a hint for doing lots of 
replacements in parallel:

	parallel -j24 spatch --sp-file smpl.cocci {} --in-place ::: *.c

If the SmPL depends on interactions between files then `parallel` won't 
work, but if the changes work per-file then it runs much faster with lots 
of big .c files.

In cases where you do need to run over lots of files and they _do_ 
interact, you might get a Stack Overflow error.  In this case set 
something like this for 1GB of stack space:
	ulimit -s $((1024*1024))

In my case spatch needed 1GB of stack and 2.4GB of RAM.  It took a few 
minutes and finished thousands of replacements!

Julia, you might add this to documentation if you think it would be 
useful.

--
Eric Wheeler
