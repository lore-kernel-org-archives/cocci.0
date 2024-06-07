Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B95C27C6F
	for <cocci@archiver.kernel.org>; Fri,  7 Jun 2024 14:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=V7r6gaZSRszhdI50Z8LDoyoHE+dr+ClzBMFz+UKK0iQ=;
  b=V7rfxsH5ETugIBPdplliAMaQYADnM+f7a3KDUdp7aPJ2wok6Ic1mTYge
   ZX/xyN54dre0fXJtJQNCFMKQvnTOkUmSujVJ+CE/zMtVQYIJurjtb1xAv
   zrjb0NGB1tz2iG/tTpUn84bH6KFk0jHO9QKblquG6KILer7G7q3H/+PbC
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.08,221,1712613600"; 
   d="scan'208";a="169589982"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jun 2024 16:50:35 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EE5BDE0141; Fri,  7 Jun 2024 16:50:34 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 524D5E0035
	for <cocci@sympa.inria.fr>; Fri,  7 Jun 2024 16:50:32 +0200 (CEST)
IronPort-SDR: 66631e37_bvmj4pmvnBliZMdRMDNATyEoBuZgrZGSwwAmPN4SWZKsJzW
 V2MLkOtoLYfzgw9XrQkNDg6GpwJn8u5tpu91Mfw==
X-IPAS-Result: =?us-ascii?q?A0HiCwAmHWNmhwMP49RagQmBT4JEfAZUMwQLSAglhCmRP?=
 =?us-ascii?q?S2EPo8JiHGBVoFAPg8BAwENOwYBAgQBAQMBA4FJgnBGAmuHeAIeBwEEMgcOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEjFwcOECeFdA2CZ?=
 =?us-ascii?q?wEQdxd0MAIBAQEBAQEBAQEBAQEBAQEBAQEXAg06QgIBAyMdAQERJw8LGgImA?=
 =?us-ascii?q?gJWBgEUAQGCfAGCLwEDMQcNBrBZgTKBAYIMAQEG2lkfLCJXgWMDBoEaLogxA?=
 =?us-ascii?q?YV8hEAnD4FVRIE8C4J4PoJhAgKBJTmDW4JplliDBYgGgxd/JguKP1R9HANZI?=
 =?us-ascii?q?RMBVRMXCz4dAhYDGxQEMA8JCyYqBjkCEgwGBgZZNAkEIwMIBANCAyBxEQMEG?=
 =?us-ascii?q?gQLB3WBcYE0BBNEA4E3BolrDIMHAgUhgXQpgSGCdwhDbBWBCAKCZIFrDGGID?=
 =?us-ascii?q?mOBEIE+gWYBT4EfgWxTJWMdQAIBC209NQYDCxsGPagcgmhILYFBAiCBI8Y/N?=
 =?us-ascii?q?AeCNoFggWIMiiGVJwYTL5c6DgaSa5hlII1WmxSBbAQvgVwzGiSDNk8DGQ+OO?=
 =?us-ascii?q?oNhM8pMQTUCATgCBwsBAQMJhUYBAYMmNIFIAQE?=
IronPort-PHdr: A9a23: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
 YZIVbJRElA4RKty4qFNA9EIZpt6DGtMrA==
IronPort-Data: A9a23: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
 FU=
IronPort-HdrOrdr: A9a23:jepuGKvsD58NeLRIYa2WtwqD7skDqNV00zEX/kB9WHVpm7+j5q
 WTdZMgpGbJYVcqKRcdcLW7U5VoLkmyyXcY2/h0AV7mZniAhILKFu9fBOnZrwEIcheWnoNgPO
 VbAspD4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAb0+40MGem+lYdfng/OXPVLu
 vm2iLNygDLRUgq
X-Talos-CUID: =?us-ascii?q?9a23=3Ae89mwmrCD0lUeBB9MQZox1rmUet8LkD0kFbOGnK?=
 =?us-ascii?q?xGXtXeKS2WHm93ooxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A1ZEdiQ7m81liA2OG6RzElGe5xoxY3Ij1Ohgnwa4?=
 =?us-ascii?q?9ppOLBRcgEi+G1Qu4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,221,1712613600"; 
   d="scan'208";a="169589977"
X-MGA-submission: =?us-ascii?q?MDH8LODpyQs78GEUZhN3JFhQ58zpFgQ8KTlcva?=
 =?us-ascii?q?nKmxreF/4cUKKoPvv0ubKfTNVixoPOoQrwrEqEy0xh3w2ycJLfP1aR/1?=
 =?us-ascii?q?U6W+v4hlbrbRv2Nww/pDdPsBtxF9FjRYxQ3pAoGV3Iolx3bbGUVIr2dk?=
 =?us-ascii?q?qIvs3adFzdt8H4RB3AwZNs+g=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 16:50:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717771831; x=1718376631; i=markus.elfring@web.de;
	bh=V7r6gaZSRszhdI50Z8LDoyoHE+dr+ClzBMFz+UKK0iQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YhAnR+87KAuiGMGm620ZkZ45GiTsRd3I8m8jndPKwZWSCyYGDNw6C3zJmn5BAUyW
	 QgzeRI4YnRa6zX5oWU5nVuZ2WhEOLR4XWN9uccQZdjGlgzQnsf8MVpbezaUs5sPZ2
	 XYt7uTk+TkKwUweZTNX0HHevYU1axBe2zcSm/qHfBZsKWx0eHBMdTsxahDtyimOsn
	 GD/9zBMLFuUazhUG7h2r39LjxhYTBY0cNbg/edMvMS5IWVK3DtRH6f/i/FHupj9IQ
	 7SDKqaEpYnIAeKTS+0FnjCxXNPHqWByIn2C5m7nuU6O30fqn3LbABok87/A5Ddlah
	 JIODMtnlb0OrNvlfEA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MWzD3-1rvbDi0hz7-00MbP6; Fri, 07
 Jun 2024 16:50:31 +0200
Message-ID: <426a5742-6180-4dea-8aca-58794dc299f5@web.de>
Date: Fri, 7 Jun 2024 16:50:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
References: <7eb9626c-da7b-414d-bf50-da1eed27be31@web.de>
 <alpine.DEB.2.22.394.2405261847380.16852@hadrien>
 <9d79a2de-10fa-479c-b720-1c4a2f51782d@web.de>
 <4bad748-afee-713a-a2d7-30b6e5c1cb28@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <4bad748-afee-713a-a2d7-30b6e5c1cb28@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OkCI0vGgf/1Arh8QyYpVw/3XmTEpoL8TxKU8aV81XNQJorxymFS
 11Dugi7mL3zOX8b14jxAQmgqCjOkCKUrfyByxsM8NJCvImyB5kX+sykH372RaRsxIMPlnu/
 ZuqrPEEhdZ20oZ9frU7eWMz+qmkosO+MqqEiSGB+hpc7ewEqLLkkg94GYvA6aeMjz9l4Atl
 sW/4v3RZGEBPMp++zKkDw==
UI-OutboundReport: notjunk:1;M01:P0:Y6SQlXsOfsM=;zJdsZx/xyEDrtXjs7ATmCkJFTe9
 Fibe+MxjHQ1Ak19HgsTThpT2qeEa7zGQfaKg/to11uQfluv71CWVPg6jyyZurSZSMCpIGABFr
 gHB7g6XWRM/80IFIBTtaUQHCHwlvOPKxAVvQzkLMkpCCqmJEnjSQghtg2i457j1/1O4lCT8lF
 1QqKg0T2DznxQybGuHTXiBda6uFEq4R7CPvpATJi99AVDb3UQfv6EWvYZASFtvY7Irv3212wc
 k+BVS4W8zqEWNa6lRSKrrKv+Jc5naVxSzCGyzvKs1oxTCpGg8d0vNFs2CW7cD5w6kls1eZ8zC
 R2d5x5AjtEqmsERL4mR3wPebz77Nza8MUjhuuiTSrG6tAKImCw+vu9OFQbWhzs5yiBscFU3j6
 iRh3s8swDlUugkoCty5BkWmRAQMP8zgifEqNE0aT84VD1OBgxVAOxnNNTfXhfVVsV33yorOnl
 U1X3gOwW10FPUZrHfsb6damsgt1JwxojhDqj4VctyJqEFMoaGeo1AJa17HdvpgBvF9wxuwaYP
 FVR+JlbBeaW0VgEe/1LC4K8GqIJI1bWF/XiKjQ9elihpcCtyQlvIS8AFZwjzFZu/4EDlQdTW5
 iW/Q358JWtTOvmYMY4Fp0gYDe3vJbSdC9zQFSv9xy2JQXP70nJMBg3Dvqm6gCjVp9aSjUA1YW
 Wbrik+hcQnCp7gq55EerlQrVdLdRKtAl5/TBsZFT2t6FY3V8oX5D2z1+r2iuRyOFzEjlfVHjU
 UZWwKFW1e7JTpZmmIHRUlv/SSAMGSJMSGgGsrlZB5m8KqBejS9lPMd62UWunpzb5SRhWrXDz6
 L2vRIW1uH2oQ9fXtUGw7OwZxDcUQLiLlYZeMbsrh1nIhg=
Subject: Re: [cocci] Increasing usage of spinlock guards (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1781
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-06/426a5742-6180-4dea-8aca-58794dc299f5%40web.de>

>> @replacement@
>> expression e;
>> @@
>> -raw_spin_lock
>> +guard(raw_spinlock_irq)
>>               (&e);
>>  ... when !=3D e
>>      when any
>> -raw_spin_unlock(&e);
>
> What exactly is the problem?

There are several development challenges remaining to make the application=
 of similar
SmPL script variants really safe.
https://elixir.bootlin.com/linux/v6.10-rc2/source/include/linux/spinlock.h=
#L537

The discussed guards combine two actions.
The shown transformation pattern depends on the deletion of the first acti=
on identifier.
This identifier should also be usable to determine a corresponding guard p=
arameter
and the companion action.

Action pairs can eventually be stored in special data structures
so that a mapping can be automatically performed (on demand).

See also:
Working with variables for case match identification by SmPL disjunctions
2019-02-19
https://github.com/coccinelle/coccinelle/issues/159


Regards,
Markus
