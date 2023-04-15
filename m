Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380E3C77B71
	for <cocci@archiver.kernel.org>; Sat, 15 Apr 2023 07:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/ThGp3JGNoUkW6xTRr7sFZZn+8A7yTr21SftMwlBQF8=;
  b=Cdg922utaWPpH7QJThFBdb3qFfJcPxw88gy7drNN1WlF2pdMP6INA8e/
   Df6aYMiIpRIvxs3AIGRuFHkuh+Se85bJvHtV2XN9WlayDSSs3ZPgrKzKb
   iSK8LgMbr3Zf4rNOekgaS+t6Vvvry4ZaLK65YbDuTunk/267h0UUxFXe8
   E=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.99,199,1677538800"; 
   d="scan'208";a="103204319"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Apr 2023 09:53:44 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4ED0DE0298; Sat, 15 Apr 2023 09:53:44 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 57011E00A8
	for <cocci@sympa.inria.fr>; Sat, 15 Apr 2023 09:53:38 +0200 (CEST)
IronPort-SDR: 643a5801_C8eg2x3bMBE3cmaBkD9Td3K1B5YhYPNebX4jiYcrcr63l/b
 tmJc5/F5UBZErA8iEPw3EI9pvTQ/RuRAXqBlCMQ==
X-IPAS-Result: =?us-ascii?q?A0F7AAAWVzpkhw4P49RaHQEBAQEJARIBBQUBQIE9BgELA?=
 =?us-ascii?q?YItdVYvBAtGhFOPDIIkA4Qwl1aBVoFAFigPAQMBDT0EAQIEAQEDAwGCC4J0A?=
 =?us-ascii?q?oU8Ah0HAQQyBw4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECEAEBA?=
 =?us-ascii?q?RoJFwcOEAUihTsGJw2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAg0HMz4BAgIBIwQZAQERGwsBBAsLGgImAgJXB?=
 =?us-ascii?q?gEMBgIBAYJ6AYInAQMOIwcMBq1bfzOBAYIIAQEGgUABAwIMAkOZdB8sIlSBX?=
 =?us-ascii?q?gMGgRQtAY0KgzZ6Jw+BVUSBFSeCUzE+gmIDARiBRoNbgmeJa4URi1qBNHaBI?=
 =?us-ascii?q?A6BPIEEAgkCEWuBEAhqgXlAAg1kCw5vgUmDKgQCFDYODh0lBA4DGSsdQAIBC?=
 =?us-ascii?q?zs6PzUJCyAGVmsCLBETBQMLFSpHBAg4Bhs0EQIIDxIPBiZEDEI3MxMGXAEpC?=
 =?us-ascii?q?w4RA06BRwQvWoEBBgEmJJ5dQlQFPiICIIE/KpY9mTqUBTQHgiuBVoFZDIoNl?=
 =?us-ascii?q?QAGEy+DfZMMDgaSJS6HMJAXIIIuiRaBb5RfhW2Bag0mgVwzGiRPgmcTPAMZD?=
 =?us-ascii?q?4t0giwMDQkVg243VINWimc/NAI7AgcBCgEBAwmFRgEBhX0BAQ?=
IronPort-PHdr: A9a23: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
 7IRR7UdWFFnT5sn
IronPort-Data: A9a23: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
 D3VxpE80tVdDH2kqSb/K8FXWdta+84=
IronPort-HdrOrdr: A9a23:06/WRakdTfO0+mXbAsqkAyaYwYzpDfL43DAbv31ZSRFFG/FwWf
 re/sjzpiWE7Ar5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6PoSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: =?us-ascii?q?9a23=3AnpXg4mrcwbrWlkuApsZIsbnmUd4jc1fc4FPRHwi?=
 =?us-ascii?q?DMUBUEOKJUHuB2Kwxxg=3D=3D?=
X-Talos-MUID: 9a23:jSj+jwQncD1cGAh4RXTQqTVEJMBRxZ6QUkUmupE3iduoLCpvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,199,1677538800"; 
   d="scan'208";a="103204314"
X-MGA-submission: =?us-ascii?q?MDG5q8C/NTFXG90JlxG5ou8U311aLzZ9I7GNrq?=
 =?us-ascii?q?3ZAr8eDSvJfbKU9lmZbLA55nh9LawjGC/QOAP1J9TI9IJE9Hj4Nm3TFg?=
 =?us-ascii?q?FVFe0Y8t07a5lxKV5I7vF/9qIIcwOku4jqSikC8PU/XPc+G5PBFxvaT3?=
 =?us-ascii?q?A1xJlZtd4qWL0MLzdQRerEkA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2023 09:53:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681545200; i=markus.elfring@web.de;
	bh=JoxfQRTxfFrS4QMJ+gGO9s1yszcs5J8QcIxbqFfg8NA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FsBhHhYCM9OqiLQl37W2WeAf4PF6FwK/niZ1dFpHOvYh6SfhuewMh/WHYff/8I+pm
	 W5PBBnezHijytH2bwoQNX/aY6sQINW9RCgiRMpaCyrXnaRMF0cqH3qAVQRbykn0SGB
	 fWnxsUopxaoipMIkyti8+N6HCByEfAQJeWI3VSKLzTWK+8YFyqmcMjHZKjnbAJLa8/
	 D/BSZ6c/iWUdEMRp0t4Id71PqcMOUVuFQMLTiVydGVCpRrL/+B8GoD5Gr/sTDe2fcA
	 H25EC3QJQ5a9ghdfN4J5BZjkmk3bfmXEAIKYx4aDzQhiYl70JFuX6j4rn7Bm4LK/K0
	 6pgCVBe9sKd0A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MaHSb-1ptJBt2CxB-00W9Uc; Sat, 15
 Apr 2023 09:53:20 +0200
Message-ID: <32f45d48-f369-ab9a-a9e4-f0ec858b0c97@web.de>
Date: Sat, 15 Apr 2023 09:52:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Alison Schofield <alison.schofield@intel.com>, nvdimm@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, cocci@inria.fr,
 LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <d2403b7a-c6cd-4ee9-2a35-86ea57554eec@web.de>
 <ZDlvunCNe9yWykIE@aschofie-mobl2>
 <88f4dd20-4159-2b66-3adc-9a5a68f9eec7@web.de>
 <ZDmmMhFTg5TaikRl@aschofie-mobl2>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZDmmMhFTg5TaikRl@aschofie-mobl2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2T4LcFGd0vhKS5AEbKrurCTLQYrvJKt3WG+HSlAjcy/du4q7uf2
 YZqzcTkfse0ngJGyKCdEF9Jakp3qM88oGmWmTveoNBuL+N5tzAbpQnrr12D7pp0FxBVsiNz
 70NxI778qVrkRmXjOOaKRPVIKgCVJi79GLww5ZBEGjhz5WradruGuoRrX9PqJdDsKrs/XQp
 NQQuJSr42Z02dBqDfC9IQ==
UI-OutboundReport: notjunk:1;M01:P0:1zULlK3cMyo=;COXQwCOl6Wpl7GVACTwXYbV386X
 NyJe06hp9+ghukTJjFBLpLHdCvZKhDR680SBb/GR/zZECHvP5XBG9ncPcHmMaZGfS0qURKUbh
 o0P6dPTDhVgle8JvNuil6lp4H2+opb9bqD738oBmDnlgbmJR7mAKu7AL2LYDAcPyE9bJREI8m
 SYxdc0vZdh73yqa31rM6LlaYHEiNqeZeTmhAf6kci/QsaiUDJ9HYbp75nMZk5QHKet3FHP/QI
 OVgq9wLRRokGV/2E2ffDX352+oxm41K4wUwge1OM3YmUaXPtdmZh+vdaNqSEQlBmpwFZ6MAaI
 2u0zStIhDIhRoV6/LJhhccMTPBOOHUs24AQ1L6JjmD90iV8u50Avy4Aj6qvFX+hX/XR7qCLsX
 olkbZ6bJGrMJVvXv+uSf3Tu79xbW8qo2wY7+Q9Sr13dvA0DYA1sdSOIVkzY3BBHo8eS4bqbsE
 ogZpawgHgw37NWYwjR6z6SGGHuwZqEhJjTcVYLBGGm89osey5oULM2cC8vSYyxe5/Ft6NliTp
 Q9zEbjB5Tpsib2bZOIMPCvKLgtiEBOE3Uzg9c6W2bxbwtSkMZVkClgXrhvPbkDjcwOwfOXzH9
 RHWVujwaZgZrfUebqDhP6z+lGmRMQ2gKxKNUMRmL2kT9yHLAHVnmkYTqgIbu8pskQab/QenSl
 Wn+oY8Dc3t9iDnn6t3hHx7hr/Ik83IREXF5bdfTVySFaLQTuHkfWxbxwRAZLqJIrqVxrdvM+9
 jDznT7LHUK5CSlpXZW8QhU74DLYOKj3+q2RH8Bh5Mn0GtQTLJ0LjTiSio0W32M/VN2r/0U2NI
 h6CIlyWVh8BRaWUG9n39hROI48IEHOmsgxdd1t/fpcJ5Vd9jPcDXA/kBsSIBQQr5t/C7bzRhK
 u3y2lQveayhOe9edmu8xvL+6L+Uot+BDyzU75hGQtfvy8jGRDaFyH3kDA
Subject: Re: [cocci] nvdimm: Replace the usage of a variable by a direct
 function call in nd_pfn_validate()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1057
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/32f45d48-f369-ab9a-a9e4-f0ec858b0c97%40web.de>

> FYI - I'm a tiny bit taken aback that in response to me applying,
> and providing feedback, on your patch,

This will probably trigger collateral evolution, won't it?


> you respond with 2 links for me to follow

I offered another bit of background information according to your enquiry.


> and cut off a chunk of my feedback.

Will this part become relevant for a subsequent patch?


> Seems like it would taken the same amount of time to just answer my
> two questions directly.

Do you find linked information sources also helpful?


> Was this part of a larger patch set?

Not for this software module.

But one of my scripts for the semantic patch language pointed several upda=
te candidates out.
Thus I sent 19 patches according to these change possibilities so far.
(Would you become interested to take another look by the means of mailing =
list archives?)


> Andy's comment seems to indicate that.

Andy Shevchenko was informed because he is involved also in the evolution =
of other components.


>>> What is the risk of undefined behavior?
>>
>> See also:
>> https://wiki.sei.cmu.edu/confluence/display/c/EXP34-C.+Do+not+dereferen=
ce+null+pointers?focusedCommentId=3D405504137#comment-405504137
>
> Where is the NULL pointer dereference here?

I hope that you can become more aware that access attempts for data struct=
ure members
(also by using the arrow operator) can occasionally be problematic before =
null pointer checks.



>>>> This issue was detected by using the Coccinelle software.
>>> Which cocci script?
>>
>> See also:
>> Reconsidering pointer dereferences before null pointer checks (with SmP=
L)
>> https://lore.kernel.org/cocci/1a11455f-ab57-dce0-1677-6beb8492a257@web.=
de/
>> https://sympa.inria.fr/sympa/arc/cocci/2023-04/msg00021.html
>
> The cocci script linked above does not seem to apply here.

Which command did you try out?

Do you find the following data processing result reasonable?

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> spatch =E2=80=
=A6/Projekte/Coccinelle/janitor/show_pointer_dereferences_before_check7.co=
cci drivers/nvdimm/pfn_devs.c
=E2=80=A6
@@ -456,9 +456,7 @@ int nd_pfn_validate(struct nd_pfn *nd_pf
        unsigned long align, start_pad;
        struct nd_pfn_sb *pfn_sb =3D nd_pfn->pfn_sb;
        struct nd_namespace_common *ndns =3D nd_pfn->ndns;
-       const uuid_t *parent_uuid =3D nd_dev_to_uuid(&ndns->dev);

-       if (!pfn_sb || !ndns)
                return -ENODEV;

        if (!is_memory(nd_pfn->dev.parent))


Regards,
Markus
