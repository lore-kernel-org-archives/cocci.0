Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1E6C282EC
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 12:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=k48toSgBXIUdM3YY9/DFAyDH0l8PjDZVDMqIJzw5QEE=;
  b=PjjOs6pyZSVvrZHVm7BKPy8DGSE0p/quUTXGZMVyPUa27SC5wDLwHzb1
   LCZPGTah0qzPFwi1KcOIrUyUpp+mam5luMe1IO8EEh7EDOFgcu+PruuUL
   53Xi0omQrg8FX3EwWHK0Ao3VgJXvVGVEwG3GswHs+gaVTyWuNWH3J1Ttj
   k=;
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
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="213477152"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 13:35:49 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 44688E0D1E; Tue, 18 Mar 2025 13:35:49 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 62E64E0260
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 13:35:46 +0100 (CET)
IronPort-SDR: 67d968a1_IBSgxSrvokEZRNg9Q8iTMTXiZysZtkaDG15pdiWqZUGXprr
 iPFxnLQX1TR0imDbV1cPrxqsUQelbGq+iuSNLuQ==
X-IPAS-Result: =?us-ascii?q?A0HUCQBTZ9lniw4P49RaHQEBAQEJARIBBQUBQIFTgkRid?=
 =?us-ascii?q?TMEC0iEVo9QgXQwhDuHO4dTiHWDVA8BAwENQQECBAEBAwSCDIJ0AosfAh4HA?=
 =?us-ascii?q?QQ0EwECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBPAUOCjGFe?=
 =?us-ascii?q?w2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREnBAsLGgImAgJWB?=
 =?us-ascii?q?gEUAQGCfoIwAQMOIwetaIEygQGCDAEBBtpcHywiV4FlCYEaLoVtgmMBhWsBO?=
 =?us-ascii?q?4Q8Jw+BVUSBPIMDPogegmmCM4RDZ5l7kBxSexwDWSwBVRMXCwcFgSlDAyo0M?=
 =?us-ascii?q?SOBIgU0CioOOCmBY2lJOgINAjWCGyRYgihqBAWBJII3hD6EQYVQghGBXQMDI?=
 =?us-ascii?q?gGDH3Ucg0h2PoRkLVCBTR1AAgELbT03CQsbBj2jSYRDF4MoOZJ9kWihPTQHg?=
 =?us-ascii?q?jiBZoFjDJ9eBhMvg3CTVg4Gkn2YfiKpEYF+I4FcMxokgzZPAxkPjiEZhBS2L?=
 =?us-ascii?q?0I1PAIHCwEBAwmFRgEBilSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 VQIeF0=
IronPort-HdrOrdr: A9a23:2fz1CKmDrFCH9MxqW8VkDB9yIITpDfLy3DAbv31ZSRFFG/Fw5P
 re+cjzsiWE8Qr5OUtQ/+xoXZPqfZqyz/FICOUqTNOftUzdyQyVxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOauEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnn1E40qgc3GfX2N9dOIE/X
 enl7F6T7HMQx4qUvg=
X-Talos-CUID: 9a23:i6l+02EBLvBiV/HKqmJV6A0FQt4iUUGM62fvHnScL2xUdoCsHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3Al2rodA6K2mvpR+DTzfkiDkFFxow35aGiNHxQrK4?=
 =?us-ascii?q?7ttuBcj15Gzze0BieF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="111901399"
X-MGA-submission: =?us-ascii?q?MDEefWSbW6h8Kb4Ed/7jCQQEUEke7k3Ao37KjF?=
 =?us-ascii?q?pMnpWoiPnsUR+pe4n8QS+WstrxLYXwvJ7Nm/OGVkh2jE+nSgv17UBAnC?=
 =?us-ascii?q?wUNwoebvf0zogdRlRReEOe8KV0aUoCEWd5x3W5efdJHxoqBkNeWtqOA1?=
 =?us-ascii?q?PFQYuN6nGZdfSVrz7cFALXiQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 13:35:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742301344; x=1742906144; i=markus.elfring@web.de;
	bh=k48toSgBXIUdM3YY9/DFAyDH0l8PjDZVDMqIJzw5QEE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GBK0hXDkb6kaKWxAjEZ51/9A03A5pqO1weWuzbagP2jMlUKcX1Dyg9/WbHpMTW0Y
	 BTGZ5LrlMRnNHmlwPR1R3P5cTrsll6EHg3FOO6qWNhsWLXWVzS5g/NSBZ1+uKnYWO
	 5oVUts4Gbyi8OabRA/hHNp1SRtKz7twCa4orFgy4sg6tcS5P0guoNNjMcyra8R6cO
	 2K6gEiWorL+Q1TCCYNlRVsbPBVB+SrFMk5gtbU5b+zslC7wkkXLbLc1sXWbR8MFY1
	 Z3e6AqEdqkD7t2lzz29alvxjrrCAi0L8BasABszMXye2RIRF6TWXgcsPVcyN4aOc+
	 yKas2BGOyqWnRP6/QA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.69]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MuF8z-1t2PaH2wOb-00ssvE; Tue, 18
 Mar 2025 13:35:44 +0100
Message-ID: <b0bb0e70-ed3e-4bd0-a2f2-3cee926ee384@web.de>
Date: Tue, 18 Mar 2025 13:35:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Olaf Hering <olaf@aepfle.de>, cocci@inria.fr
References: <20250317213619.14674-1-olaf@aepfle.de>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250317213619.14674-1-olaf@aepfle.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:EXAq64FDi7Ejfs/EYbYx5KKcttBgDsFJMk3QqVMFhtsWc/FtD/Q
 +knQNr/5yUyz85xWnrCei+j5Kd9QVnLzXfLybL6h8CAVsA9posy+Klrw4gTgCSEwWIyrJnT
 sVtPtwqV7hKNFGAwaT0dhbKjrdSFTcU1+ib2srHwgv7+UG7CT6+ttMw9XxbpA42BZDACdzu
 ZYdmx4YG8qEeoy/lJXUZw==
UI-OutboundReport: notjunk:1;M01:P0:jioZvXPGEUg=;UtlpShlzCY8TshdUXwG5iIuWaXW
 BoYT+EHUCQmMC3A7UF0sSPuauVy/EGOEaatY7JeNZ8AlmpM0lSI7BV9hu7H+n6SyMylHoQAUE
 RfwWEa8iUvLgQ6qy56Gq9uwNg0Au7nyTPidE18rI/q2vMwLnfF0RkeZMw/6V+7azSMP+SO633
 9OJCEr+SeJiy45W36okm9ocQxDscUdoYrLM558uj3xjgs8eCdKOfIBvhKsx/Ym9uM+D/vdFi9
 I3HvyFCDHY4p8LLfHjUh1K/ArwtSmPCuP5sLNZuDydwDCeNrqd1/Ky95fd9pC+CKW2vLAA6Yf
 +NGfnWbyx2hnXXnJHTLGdH8qEAIS+fbetVVrst1OVembTjri4UIOhgDXW41Avp9nbXgPK9FFR
 NgWIVNOSlXmXsa/uCvPPsDU3uXl6AGp7pprC2KmdCXVmFaoNDO5Db6F2Rf97itllLqKhBiveL
 rbBeZIMPvS8XNSQcezU/6Kw/ahCNAeTtHN6bXbHy44aePiisyNZ2Hkvyd6gOF4RuVOXUkaHkU
 iecIPS1EGeOr+FxLnPfNXmPP/cgM8rdcvl29bdasY9NUQqWuPGqlj9dLSWURCrJi1J8bRwbgN
 rEUZXIyY/Krl6kLertY3PzJRB0rY39ZtrBF57iaM9+WltObJaaUTJx5sPFa+kR+BtxFhrjhQw
 s4TRD7eS20YkOod12sSXgHQjvQlt7gBikLb3xma3hz1fszLfrrcu01K7ElZznjgHxXfvPm1G/
 yARzPcS8Vk1BTpC0e05EI0Ag3Tb7ZZGdgE8PcAdRpHkmO1GcgsDWBktL+6pv/oKuZVXStixQO
 Y6dEYXYz718jtAnZrnAl2MC4MQKStBkC8C7P8YkAQKBHTvf2/GgBFIapP5QhJ2za5Osvnnl9k
 lFbYa2gPmLNZDyfK3C+t0xECvD13rOFdZakUffyIXmAjyHBpQQ+5hcL/M+AnEQWZeqfPD5HhH
 06XT7OioHO3VSCBrCcr13Wo+W5czXBwC/X/GvqpJrCTQreWYVzJxs3j9+xSo+1hwM45Gg7y9t
 In0EutglkG0nGVsvXN9UoQ976XbidfuvrbvPak0U/M/77sNZ6BMLiSgnRgkxy+pFAZi2kbW99
 Xwr6ChqGzDYPQoBRKO0nNoBjOSSmYFhyyP30Ak0YawpCJEVDl9TOLZZpMUu2umV5gf+Nsxiko
 JUjaiObiVvN0NWdUf+79C9A82/YpQnMO7NtnIVrGGnWodgfypIeNCvetr8XUF/A7zR+gH64d9
 UgWONKWQ5g5bfdCce6CioIZiqCLuEdt3kaOT0NDuilL/x8tYqk16xGMzttwoyqX9cgv4bDQI6
 M5We4QfS0Di2YPWhgx9QXmfpICfQ7QGEji892V2nDxICPm0wif+VuH0t7w2XAD1ur7YN2jbLn
 jM9DxhymQuND8OoDvGmh8BHZHUzUY1fQIGfMHYue9LG00CW39qKtr32yoCCwTERRU7sM/1Wns
 Inf0TiDkh8D2AbBAAu2AhSEuHxsM/bbBOOPdXK8SJjm4aFE97
Subject: Re: [cocci] [PATCH v2] replace pcre with pcre2
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2616
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/b0bb0e70-ed3e-4bd0-a2f2-3cee926ee384%40web.de>

> Since pcre is unmaintained, the usage of ocaml-pcre will be replaced
> with ocaml-pcre2.

I find it interesting how the software support evolved for such
a programming interface in the meantime.


>                   While other regular expession libraries for OCaml
> exists, they are not as feature complete as pcre2 is.

I find this information not so helpful here.


> This is the minimal change to use ocaml-pcre2. To reduce the size of
> this patch, a separeate commit will be required to import
> pcre2-ocaml.git into bundles/pcre2.

Would you like to avoid typos for a better change description?

Regards,
Markus
