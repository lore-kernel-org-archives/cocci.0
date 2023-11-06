Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC344C4332F
	for <cocci@archiver.kernel.org>; Mon,  6 Nov 2023 13:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=FytwnZNINUm01CEG8H86NQMpBeeF77hZxLra15Geq3Y=;
  b=hoP6pXTJ5tD33Yb6HV83D2f+br4OAicsB48nqdhE7aNvVh2HUHYfqJ26
   0ZzWcRxNYjE9ZW6hnmRI/Cr8QD8OcOTAE1MXJzfiy9roICZ1m2gzYh5TW
   LfSIX+EoAMzZgJh+fzb7B6dgaJotzSmTVJqF+EW95XXhgnZ6nyUOntIX9
   o=;
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
X-IronPort-AV: E=Sophos;i="6.03,281,1694728800"; 
   d="scan'208";a="134822832"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Nov 2023 14:56:12 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 64C5AE00BA; Mon,  6 Nov 2023 14:56:12 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6DBC4E00B6
	for <cocci@sympa.inria.fr>; Mon,  6 Nov 2023 14:56:07 +0100 (CET)
IronPort-SDR: 6548f076_dA2fW/iNu8LMJ0S4lYvCv0h6FNuP2AiK3zq2QVB7gry0Ocb
 loflqjHdjth/E4bk/22lCkrh6inc2gQYDwlGhgQ==
X-IPAS-Result: =?us-ascii?q?A0HLAwB170hlhwMP49RaHgEBCxIMQIQIfVMwBAtIhFOPP?=
 =?us-ascii?q?IF1gQ6DXYc0h0qIb4MWPg8BAwENQQECBAEBAwQ4hEcChygCHgcBBDQTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAhABAQEjFwcOECeFaA2CNysBE?=
 =?us-ascii?q?YEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXAkdCAwMjBBkBAREmAQ8LGgImAgJXB?=
 =?us-ascii?q?gEUAQGCeoIqAQMxB6xUfzOBAYIJAQEGr1QfLCJVgV8JgRouiAoBhVGDO3onD?=
 =?us-ascii?q?4FVRIE8C4EJgTcHMT6EQ4NbgmiJLgcygiKDVI0CXiIFQnAbAwcDgQAQKwcEM?=
 =?us-ascii?q?BsHBgkUGBUjBlEELSQJExI+BIFjgVEKgQI/Dw4Rgj8rNjYZSIJYCRUMNQRGd?=
 =?us-ascii?q?hAqBBQXgREEah0VHjcREhcNAwh2HQIRIzwDBQMEMwoSDQshBVcDQgZJCwMCG?=
 =?us-ascii?q?gUDAwSBNgUNHgIQGgYNJwMDE00CEBQDOwMDBgMLMQMwVUQMUANsHzYJPA8MH?=
 =?us-ascii?q?wIbHg0nKAI1QwMRBRICFQQOAxkrHUACAQttPTUGAwsbBj4CJ6JuA5Vwkw2eY?=
 =?us-ascii?q?jQHgjGBXoFfDJ8jBhMvlyAOBpJMLpgQIKgxgXojgVwzGiRPgmdPAxkPjiAZh?=
 =?us-ascii?q?BKPCQE9QDU7AgcBCgEBAwmFRgEBg1qCKQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:wWKSKKG0i6wAQL0cpLqEzMeALOsnbusQ8zAXPhhKOHtomszxra
 +TdYcgpHnJYVEqKQwdcLG7SdO9qBznhP1ICOUqUItKGTOW3FdAT7sSkbcKoQeQeREWn9Q1vc
 wLT0E9MqyUMbEQt6jHCXyDc+rIt+PnzEnHv4vjJjxWPHhXgulbnn9E4yigYzZLeDU=
X-Talos-CUID: =?us-ascii?q?9a23=3AhBUKh2qvXOPTbXOW+s5OCpvmUewiQH7c42nAGk+?=
 =?us-ascii?q?bByFPebiYUVyP0Zoxxg=3D=3D?=
X-Talos-MUID: 9a23:3JddxAVWCsrR2L3q/C3viGF/Hewy2oGnOhwXkaQ9o/nebiMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,281,1694728800"; 
   d="scan'208";a="70637378"
X-MGA-submission: =?us-ascii?q?MDGU5MFj85b7BGuG7e/nayHHXiJPQHYioGC/vN?=
 =?us-ascii?q?8YMcEmt4RDrcIRejZ1sGaLiuVe8+WwxCBoWiy61LDjQk0h62GToAdJRy?=
 =?us-ascii?q?ghYbjsyiBl+ooOzV5vqchZbZZTB9X+qLYTfPTjpKMalv4qb9Ilm6KOmL?=
 =?us-ascii?q?KtOeT/g9Ajay9ycfLGCEN1TA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 14:56:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1699278958; x=1699883758; i=markus.elfring@web.de;
	bh=kFbPt8wA64kH1Fx+nFwGspfN/LdLAlP11MwnD3aQQcg=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=LT1HSDfC+siCRj0fPno9lnEdbeY3g15jtam75z2TTATroGvQQs26L84a0IoghbGE
	 zhg9j5MpMvWLZOQW2ZIz2bY5tjvh14dg6zE3XiXNrPx1xCW2dcZEtXM+VvSJ9Gxvl
	 /smpfNPO5qF4VTXVRZf3n2Sr1cbuwFSjnW4CbHljltcBEnMa76q6w7R7EtG/uCQx3
	 a6NGzTHiXfKT+lJVy/4W0kKvuaI67Yi6jC7BOizlEGyESaUNzG2t0o4Ngn88ttdIA
	 29nV6EZeKkRryDKw9/USC1DG0Wk0pNYzBAs1hRpLI/5TDysQFAcLDLMQnjZBr4JwT
	 gnoC3ekNLTN2qcJTmg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MN6FV-1qjiFX18sP-00IlI9; Mon, 06
 Nov 2023 14:55:58 +0100
Message-ID: <2b5e219a-85dc-4347-b5d0-86059181be93@web.de>
Date: Mon, 6 Nov 2023 14:55:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wojciech Drewek <wojciech.drewek@intel.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jakub Kicinski <kuba@kernel.org>, Justin Chen <justin.chen@broadcom.com>,
 Paolo Abeni <pabeni@redhat.com>, bcm-kernel-feedback-list@broadcom.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
 Simon Horman <horms@kernel.org>
References: <0b2972cb-03b2-40c7-a728-6ebe2512637f@web.de>
 <83b0921a-5718-4dbf-b9bd-5662e47e3807@intel.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <83b0921a-5718-4dbf-b9bd-5662e47e3807@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:riWI2eTVON9/gUCdlSdU9CMhZwjp9iBExERQ7Vjhov4cPka+wJx
 Mi/lN2Ae8p/Ld36Ez66yoV64Z9Xo5TAGX3n6zWU9ZC8Snn3YxWOScMjLO8o+WRg6+z/B6Wl
 XvuIxg6QQLbUmQ3vpdZ4mPDIyVSaFcGoPuA4HNLVOES01ERF3XPYY4BbBxTx4us5EiH7SyL
 wTjHaUAaqUGSG6ht7iqew==
UI-OutboundReport: notjunk:1;M01:P0:eGt8JrO+jKc=;urrTiZOBRUrqOaf6hiur9o6Fyga
 rBpnMBo5jTt+a0qjCJvPOxg+PO1IKxuaozLAZDyNO+htCohCk6Gstb2wBppVw20lYN+rmCyvo
 U7FejUGYpYMWp8dFuxGqUPQEvOwyeZZAUwzHFyVjCiI6PMS5plIEr8sWJFZ1bOrM8FS8dTlrm
 Eg75yA7RMLsJTTwVMluPutplelRFJmvrYLBCpb4PvShchNQnQuX2hlsy5j0vS3KeZYpEI//l/
 RYHZNrvlYripwv6PwW0x68677optoy9xhWPVeKaE3bqKQUduFc8qFl7I1ALYsA9WyzVwQ5gHP
 ze9JfvPK/3QkCwsJUXpRZS2Jggx2WqzISXh2HodAobVj0i8F30nblRt4q06VSkcevBdTDQf54
 /VDucCb1g1BTHBlVWBcjvMkBEE9PKH4kmWZceI51nuNXrWO/D4NZpV1OT+GIEeNVi5LTH2z7l
 l5qMPYi+Ou50lPIHyVviM7ymYTdLieAhbT8Gyp4iqv4UG3pUQMOZoabuoLEqZ+OoMFrg0uJCt
 Sj7ykqKRS5vV/jtcIalZzdGt31gRHF+Xrh7yBbEfzYRHiyC4jYRCq2Rd9upvvw/SSjX2pjq4m
 BP/Wvk6mN13xmhN2alHakKqoWC7a6vji5CneyUms+ZjUkvetM9ol01hpGb/VUN5MyWebs9/Kt
 d6dypakyRL3/vcEMjs/AUMz6VKFulA2zHFZoVYsOvSZ7TvcTqmzoec44odUtGj3oicwhw7C1e
 Dhw8JjZaWv7wvtxcQaRYrTSY5O3MX4gay2IHTNXRhVtzUi94En2yVC6CwkqLavatMAU3G9alD
 i9fFT476ukx5K/ERWGPoPsFEbnbdPU0j7L3Gtgn3Uj5BJSHrdjSc3dzpQVTHN6eXHZ4zRPAB0
 fN7QIzuuI2Wp8qFmwmIfE7hqKKTvOo7TXNPi5gHIZVTJF/4A91wcDWt1IwWwZwwY1gvVsS9fN
 nz44ng==
Subject: Re: [cocci] [PATCH] net: bcmasp: Use common error handling code in
 bcmasp_probe()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1291
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/2b5e219a-85dc-4347-b5d0-86059181be93%40web.de>

=E2=80=A6
>> Add a jump target so that a bit of exception handling can be better
>> reused at the end of this function.
=E2=80=A6
>> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
>> @@ -1304,9 +1304,8 @@ static int bcmasp_probe(struct platform_device *p=
dev)
>>  		intf =3D bcmasp_interface_create(priv, intf_node, i);
>>  		if (!intf) {
>>  			dev_err(dev, "Cannot create eth interface %d\n", i);
>> -			bcmasp_remove_intfs(priv);
>>  			of_node_put(intf_node);
>> -			goto of_put_exit;
>> +			goto remove_intfs;
>>  		}
>>  		list_add_tail(&intf->list, &priv->intfs);
>>  		i++;
>> @@ -1331,8 +1330,7 @@ static int bcmasp_probe(struct platform_device *p=
dev)
>>  			netdev_err(intf->ndev,
>>  				   "failed to register net_device: %d\n", ret);
>>  			priv->destroy_wol(priv);
>> -			bcmasp_remove_intfs(priv);
>> -			goto of_put_exit;
>> +			goto remove_intfs;
>>  		}
>>  		count++;
>>  	}
>> @@ -1342,6 +1340,10 @@ static int bcmasp_probe(struct platform_device *=
pdev)
>>  of_put_exit:
>>  	of_node_put(ports_node);
>>  	return ret;
>> +
>> +remove_intfs:
>> +	bcmasp_remove_intfs(priv);
>> +	goto of_put_exit;
>
> Why is it at the end of the function? Just move it above of_put_exit and=
 it will naturally
> go to the of_node_put call. No need for "goto of_put_exit".

I got the impression that the call of the function =E2=80=9Cbcmasp_remove_=
intfs=E2=80=9D belongs only
to exceptional cases in the shown control flow.

Regards,
Markus
