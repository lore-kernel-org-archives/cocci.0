Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCB6CE8E91
	for <cocci@archiver.kernel.org>; Thu, 24 Oct 2024 16:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=OCiKVhKAbwMPRBGIccwS37xziaEPThRK0VLaR+F8OeQ=;
  b=Wgy8BVhkxaD90bE7X/79bwc8rd62OoWU1ZQZWrxcdbqPbFmSamu1RKXx
   uQJha6O6VNYMK34urQtPH7XyEvz/dBAgQz5uOzeoAXPBugdUxQU75A33J
   f1WHEEm4Fgycr6JbgPabux88j2hoyIWNrEj7Lx/Ijl2GSxiOIxQxc6Mlz
   c=;
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
X-IronPort-AV: E=Sophos;i="6.11,229,1725314400"; 
   d="scan'208";a="190604394"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Oct 2024 18:16:38 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2E10DE0D1D; Thu, 24 Oct 2024 18:16:38 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4960EE013D
	for <cocci@sympa.inria.fr>; Thu, 24 Oct 2024 18:16:33 +0200 (CEST)
IronPort-SDR: 671a72df_Jvv5a2vRANaULEBQqr4slX9U9H5GeTYL9mNylqxIypZGsQI
 lfVrX0ALwY9KrrmM1mG7fnOq/RSjb+VECOHd0Ow==
X-IPAS-Result: =?us-ascii?q?A0ELAADHcRpngwsR49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYJDYnUzBAtIhFaIHYcwgXQwhDuHOodUiHWBVoF+DwEDA?=
 =?us-ascii?q?Q1BAQIEAQEDBIIMgnQCiiQCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFA?=
 =?us-ascii?q?QEBAgEBAgQGAQIQAQEBOgcOCjGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHR?=
 =?us-ascii?q?AEBAQIBIx0BAREmAQQLCxoCJgICVgYBFAEBgn2CMAEDDiMHsDKBMoEBggwBA?=
 =?us-ascii?q?QbaWx8sIleBYwmBGi4BhWmCYgGFWUuEPCcPgVVEgTwLgng+iB6CaY43g1KHb?=
 =?us-ascii?q?Yw+JW6EBo1lUnscA1khEwFVExcLCQWJNQqDHCmBRSaEEQiBKxOBG4JEgWcJY?=
 =?us-ascii?q?YdlXYEMgT6BWQFGgnJKg0yBYQU4SYJNak43Ag0CN4IkJFyCT4ElBAWDPIEvH?=
 =?us-ascii?q?UACAQttPTUJCxsGPa4egnmiR4VdoTU0B4I4gWWBYwyfVQYTL4NyAZNNDgaSe?=
 =?us-ascii?q?Jh3Iqh+NYEyOoFcMxokgzZPAxkPjiEZhBTKDEE1OwIHAQoBAQMJAYFVg3ABA?=
 =?us-ascii?q?YlZgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:sDtITKsyt8bHVEBbYEtLTG9G7efnVItaMUV32f8akzHdYApBsoF/q
 tZmKWjVbK2CZWanL9h1at6w9RkPvZXVyoI3SwRu/3swEShAgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTrSCYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbCRNsspvlDs15K6u4WtC4gRkDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNz94X2mVTKlLjFVDmZkh+A8BOsTAezsAG6ZvXAdJHAathZ5plqPgqo
 DlFncTYpQ7EpcQgksxFO/VTO3kW0aGrZNYriJVw2CCe5xSuTpfi/xlhJE09HrAz9flwPV4N3
 sExIRpdTSmIie3jldpXSsE07igiBMzsIZ9ZpXxqiz3UZRokacqaGeOQv4AehWh235km8fX2P
 6L1bRJKZQ7DfgYJF1MZEpM4k8+3i3O5fzAwRFe99PtmvDWMkVUZPL7FPff1JdCMb8hsmgWDo
 k+Y1m3iPDxKO4nKodaC2inw1reUzXyTtJgpPLa//fVrqEaCw3QaThwQT1qy5/ej4ma6Us1WL
 0g86Csrp7I7sk2tVNj0GROiyENopTYZXMdMVfI34keBx8I4/jp1GEAIRR18Q9M5s/MJBhcX/
 1ajz/DQDjJg5ej9pW2myp+Yqja7OC4wJGAEZDMZQQZt3zUFiN5o5v4oZok4eJNZnuHI9SfML
 yeigAVWuln+pcsMyrn94l3NxT6hznQocuLXzlSONo5GxlonDGJAW2BOwQaAhRqnBNjCJmRtR
 FBex6CjABkmVPlhbhClTuQXB62O7P2YKjDailMHN8B+rWXyoy7/I9sNvm4WyKJV3iAsKWeBj
 Kj75lI52XOvFCb7Pfcfj3+ZUJ90lvi8fTgbfqqKM4MeCnSOSON31HoyNRbLjz+FfLkEkKY5P
 ozTasvEMJrpIfQP8dZCfM9EieVD7nlmmwv7HMmnpzz5ief2TCDPFd8tbgHQBshnt/nsiFuOr
 L5i2z6ikEw3vBvWOXCPqdZ7wJFjBSRTOK0aXOQMJr/Te1s7SThxYxITqJt4E7FYc21uvr+g1
 hmAtoVwkTITXFWWeV/YWWMpc771Q5d0oFQyOCFmbx7i2GEubczrpO0Tfoc+N+tvvuFy7+9Gf
 99cceW5A9NLVmvm/RYZZsLDt4BMTkmgqj+PGCuHWwIBWaBcaTbHwfLeRTu3xhIyVnK2keAcv
 4yf0hjqRMtfZgZ6U+fTRvGd73Kwmnk/w9BNflb6DeRSXG7O84FaDTP7odFqAsMLKDTFniC70
 STPCzgmhOD9ma0H2/iXurK19KKSDPlbMndBOmvmsYaNKijR+1S8zb96UOqneS7XUEX28v6AY
 dp54u7dMvpdunp3qKt5TqhWyJwh6+vVp7N1yhpuGFPJZQ+JDpJiOny34tldhJZSx7N2uRqEZ
 WzXw4N0YY62AcLCFEIdACEHbe7ZjPEdpWT03MQPeU7/4Hd6waqDXUBsJCKzsS16LoZuEYYb0
 Owk6d836Qu+t0IQCey4rBtorkaCEn9RdJ8clMA+IJTqgQ8V2F19ccTiKivp0qquNfRIEGcXe
 wGxuoSTpo5h1nLjcmUyH0fjxeByp4oDkzEUwU4gJ2amoMvkhPg21iIAqDgcE19n8TRa4c1OO
 0xAFU58FYOR9RhG2elBWGGNHVlaJRu7o0be9XoApFf7fWKJCFPfCXIbOPnX2lI06EdOV2F/0
 JDB70i9ShfsXsX6/hVqaH5fs/a5EOBArFzTqv6oD+GuPsccYwO8poSMeGBRiR/sIf1ptX39v
 eMwodpBM/zqBxUx/Z8+JZKRj4kLaRa+I2dHf/Ft0YUJEUzYexCwwTK+EF+wSOwcO8319VKEN
 OI2KvJtTxie0AO8ngIfD4MIIJ52m6cNz/gGcbXJO2UHkuW+qhxEjZHuzRX91VQbG4hWrcUAK
 43qZ22jFE6UjiBqgGPjlpRPFVe5RtgmXzfC+t6J3t8HLa9ej9E0Q3oOiuO1m163LDpY+wmlu
 VKfRq3OkM1n54dev6rtNaRhXDeLCM7Be9mJ1CuRsN1+S8zFHumTlgESq3jhZx93O5lIUftJt
 L29ivzF92Kbg6QHCEXihIukO5RSwMePANpsLcP8KUdFkRu4WMPD5wUJ/0a6I8drlOxxy9aGR
 QziTueNbv8QBslgwUNKZxhkExoyD7r9aoHir3ifq9WOEh0s7hzVHui49HPGbXBpSQFQAsfQU
 jTLgveJ4sxUiK9uBxVeXvFvPMJeEW/ZAKAjc4X8iCmcAmyWmWi9g7rFlyc7yDT1G3KBQdfb4
 5XEe0DETy6Mmpr0lfNXj48jmScsLidNsbFlNAZVsdt7kCuzA2M6PPwQe8dOQI1dlivpkor0f
 nfRZW8lEj/wRilAbQ662tn4QwODHaYbD78V/NDyE5+8ME9axb9sAYeNMg9l5GpqPCTuxqerJ
 LnyP5E20geZmvlUqSQ7v5RXQtuLAtvFy3hO9U2VfwnaHUMFGbtTvJB+NFMlaMEEev0hUG3UK
 GJzSW0srIRXj6LuOZ4IRkO50y31cN8iI/vEoMtPLBviV12n8dB9
IronPort-HdrOrdr: A9a23:d9yWdKrQ/0hhRZpui3Y+svgaV5r/eYIsimQD101hICG9vPbo8/
 xG785rsCMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAb2SS5vyb3ODXKadC/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-Talos-CUID: 9a23:wzK/uW3XTn4dY1qkJ6WJ0rxfFssGT1bS03DsHAyTNE9gYu22cFSe9/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3AKNgUEA7EEzCe9CLQ7+4ig/s8xoxlzoTxBEYnnKw?=
 =?us-ascii?q?C+NKAGHJZMiyjoWS4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,229,1725314400"; 
   d="scan'208";a="99975751"
X-MGA-submission: =?us-ascii?q?MDEO1VpfZU5i1NOyKzOhPOvXchKWWtBIB5tZVw?=
 =?us-ascii?q?NLOaCq8XqdfubKjNowVGRLGVtzQg9Sb4r2jA0kgiEOHUlCyKygILjnfk?=
 =?us-ascii?q?r1ZlY9D8TbeTW8kXEOvFD6NAM70HKw5Qpd4yNcYUsuaBYH7X0tZY0O9p?=
 =?us-ascii?q?s/smEKIROAHVGLp1IqsCTVQQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 18:16:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729786590; x=1730391390; i=markus.elfring@web.de;
	bh=OCiKVhKAbwMPRBGIccwS37xziaEPThRK0VLaR+F8OeQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Uh01/Zdj5dvswxPvu6dAVcmcN+IUpyT++tgferQSaPqfb2BS5xJo9GyuMOWed27P
	 nrUXDRGxdsdxU7ek/So38p89PzVmle9ZqZWBEKRxoGCYqixY1iOUtB2DFn7nqcksf
	 +KNLc5ctRYtbsAAX49/LbuUPkO6eQIPOUR051w+EsLBxd03s2sppF5OYZkGuvnJoW
	 Ba2YZcaq0x73fo1n+tUBT7VfoMHYRFqywRrVKgu8JOVxgdrzm3szf/fJppV4/2xgL
	 6jijPyZ1Pmt//XlpIMiUWQQBLYnrGZaW74iPtN0zu/DAam8/TKDI+TXdTf9d+KCNq
	 aoR/JrPuzU9N2zIFkQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSZHv-1tSO3j0Xer-00NXis; Thu, 24
 Oct 2024 18:16:30 +0200
Message-ID: <bd7afa99-024a-4543-bb72-0db2282943d4@web.de>
Date: Thu, 24 Oct 2024 18:16:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241646040.3352@hadrien>
 <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241728210.3352@hadrien>
 <4872cc2f-3ca3-4bfe-b48a-ebbe5ab8a534@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241736480.3352@hadrien>
Content-Language: en-GB
Cc: "Derek M. Jones" <derek@knosof.co.uk>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2410241736480.3352@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:AyovEe87+6NHyrCBm59i+WeUzZJgj8tSe2/R9BcqTh19x6fLip8
 QXgvv6eYTiyxVgl17l8FrK7KogXfjW0Fg73NfYAsFxXW/T7NJYqUyghu9Y7vONaROmRm/Zq
 lWhpV7xTiynMfv/MEilHx5MiycCtMnb1y4u6v9FSisWqkVxxbQG/vn69h65r8KfcBhTv0In
 4fXkxMF/mJZeKTMYMzuMA==
UI-OutboundReport: notjunk:1;M01:P0:TtO6l+v6OrI=;MCpoGU8b3SJHLmNq5w9oYyKUh9o
 k0BNuROAWAMOAUNKGoyQyPDQyiHGduRIXfTF3NyByvKM4mU/1p0h9sWA94M9h4/agTze15rCe
 P5kNCP+W7mK8m8p185cXzzZxv/X+ovvPdibpUBiLIO7RTRflJW5a4F0czeJTDSabUpmJ52/Hb
 o/1hsNfyGZp+PxmwAzXC0KjeNxgcl47nzpI9M2q1wQ6rV+pRM5Ah6OBQE6axqMok+yBNmj0vm
 kbEfE1Q4xVD+6lD6blq2PA5zuW0DqbK/ZXqBB2tzP6WEsBGMVuN5FkyE6PuT5sQLZq1RdIlSr
 CchLtklxaUsu0MPALS5CqOBxtFszJPNEiOmOxxdDKYkRmf7XTkM89Bs+ov2lSVdXlH+Ek99y6
 /YV8qMQAd11v+xOJkT/ndifq5cV/zYt5tFRQ2kGPxRcUQgCQDD/wEkVQG9QpJrZS55yQV4fL9
 6xOdi83ROLOay94SJZ+44isajQ0jqGtuK35nJ7WFMq8YTSJidjpftJPbgJYAS7A3qMZW1OA3r
 k80UhcOaY136uA71MeU+fDxcuzUtLmx8NVB5lPlYikSsKG7C84SIWPbxggsgjvs/3DW+g3gzj
 +RTndtpakUFCqgGaoGxYgPQr6nTTcGaRlfCmYP3vxLLKJH4nWiTMN73t6mIDYK1CHnQATZ5Dy
 b8y4r7Fo/lmkK+PocSKQnkk14sGka38E54AxowXXQDDYP0h0sll4wy3YBUc9BieEdEbfA4CfM
 EqiOzstepXc/ajNywxFLeVyDvapYgPEgrwkEdEx/F1PzGCcJpvgBn0BBC8wYiNDE86xtmqM4B
 x4vj3lLD7iBI9+09d+OprwBA==
Subject: Re: [cocci] SmPL position variables =?UTF-8?Q?=E2=80=A6?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1930
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/bd7afa99-024a-4543-bb72-0db2282943d4%40web.de>

> Every position variable contains complete information about the enclosing object.

Will such information trigger any improvements for the software documentation?

Regards,
Markus
