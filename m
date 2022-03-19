Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4E1C433F5
	for <cocci@archiver.kernel.org>; Sat, 19 Mar 2022 11:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=LVuA0pTsEGuKwrwwgfWUnFsU4nMCgDpcOm9F3fPezFw=;
  b=tD599BYADS9d+tqfoQ9thk5nZ0s3pK/wF1iGIcDeCdXkzrT5TBrFF7Vb
   2ZkkLiD+kHt5JwDJCI1jlcUu5cqLrh4n2T+o+AW7d7tudbdL3wTRiksO4
   gHU3pHzAOgPP8JPbsPHwWAvjI1W0pdSN3jEIEYkqXpZbeU+hwuUUl3pGP
   8=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="26993687"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2022 12:13:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2039FE020F; Sat, 19 Mar 2022 12:13:13 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8CC60E0069
	for <cocci@sympa.inria.fr>; Sat, 19 Mar 2022 12:13:09 +0100 (CET)
IronPort-SDR: PZLGbW/piIun5jvi8kFesnjXW9Cox3CPd/8wqtbEowvf/wUoaiWErzkfcXazdPzrgZ0kxdIfXY
 lXBngJDm3SpfFKxANT2/xDe0eqp4cZfgbI845YlDFH3KQyEJxdamr+aHj/FnrUhBrv7q8cwd/v
 ZTOYBC/FcyXA6nNrjXS16H8GmP8nJUakeJ2LJaPJJ010OqcYTu5GByz/p41mxcCT7mnSXJVChk
 TtvGNlibB/nNxIyURgXDc8/sZGQM4skw3OTGzB/LVIRpU34not0mQNeHB/dFt5elh0YrYQX7lU
 VwidQjaMdbBmVP7iSLY4ms4Y
X-IPAS-Result: =?us-ascii?q?A0AYAgBuujVihwQP49RaHgEBCxIMQIQCflcrBAtEhBY+k?=
 =?us-ascii?q?RuSPIwjCwEDAQ05BQECBAEBPYRKAoQ0Ah0HAQQ0EwECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEDAQEFAQEBAgEBAgQEARMBAQEMDQkFCAoHDhAFNgZeBmQEgUsEgXQLNA2CN?=
 =?us-ascii?q?SKDbAECAgEMFx0BAREmAQQLCQIODAImAgJXBg0IAQGDAAGCZAEDDSULkVycD?=
 =?us-ascii?q?IExgQGCCAEBBoE/ARNBgjQfLCJSgVsDBoEQLI5JJxCBVUSBPAyCRzA+gmMBA?=
 =?us-ascii?q?QKBXoMagmWYEmJZwm80B4ISgTqBQQyJQpRPBhQulj0OBpFtlluNFZltgXiBa?=
 =?us-ascii?q?Q4HMxokgzhOAQIBAg0BAgIDAQIBAgkBAQKOHQwNCYNQM4ELiSFANAIJLQIGA?=
 =?us-ascii?q?QoBAQMJhUcBAYoFAQE?=
IronPort-PHdr: A9a23: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
 QPNo9Qor1z0yoGy
IronPort-Data: A9a23:CrNUoq1rcYrYMnxVh/bD5ap3kn2cJEfYwER7XKvMYLTBsI5bpzMEn
 WMYUG/VPqrYZjGjetFwPY3k80JV7ZKHm95gTAQ43Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/nOH9IQMcacUsxLbVYMpBwJ1FQyw4bVvqYy2YLjW1jU6
 IuoyyHiEAbNNwBcYjp8B52r80sHUMTa4Fv0aXRjDRzjlAa2e0g9VPrzF4npR5fLatU88tqBe
 gr25OrRElU1UPsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt/R64
 /RIvqe0dSUSebzHmcI9CRdULT4raMWq+JefSZS+mcmU0lGAbHbmhfljZK00FddBoKAtWz4Ir
 KFedFjhbTjb7w6y6JeyUOpxnYIOKMfxPYUQkm5tx3fVAJ7KRLiSG/ybuIQEtNs2rthwPsfbP
 PcJUitmY0TAO0RuIQ5LJ6tryY9EgVGmLmEG8QvLzUYt2EDYywd60ZD2Id/Nc5qLQ99UlwCWv
 Ar7E3/RBxYHKJqAxDDD/n/EavLzcT3TfIk5NbizzfpWombU12cSLj1MW1eFvqzs4qKhYO53J
 0sR8ysoiKE98k23U9XwNyGFTG64Ug00BoIMSLdmgO2Z4vWEulbDboQRZmMZMLQbWNkKqSsC+
 nLhcznBIDtprLSfQG+Hnlt/hW7sZXFNRYPuTRUEQAoD59DlrMQLgBvLXL5e/EOdi9roBXfvz
 jrMoCVWa1QvYSwjh/jTEbPv2mzESn31ougduF+/soWNsFoRWWJdT9b0gWU3FN4ZRGpjcnGPv
 WIfh++V5/0UAJeGmUSlGbtRQ+z3v6vbbm2D3TaD+qXNERz9oxZPmqgPsVlDyLtBaZlslcLBP
 ROC51gLjHOtFCH3NvUtC25ONyja5fG9SYq8D668gitmO9YoPA6B4Cx0Y0OMl2ni+HXAYolvU
 ap3hf2EVC5AYYw+lGTeb75EjdcDm35irUuOG8GT50n2idK2OS/OIZ9YYQvmRr5itsus/l6Km
 +uzwuPRln2zpsWlPnKImWPSRHhWRUUG6Wfe8JUGKLTcflI4RAnMyZb5mNscRmCspIwN/s+gw
 513chYwJIPXiSKVJAOURGpkbb+zD59zoWhlbzMhNxCk1iF7M4qo6a4ecboxfKUmrbAyk6QrE
 qNdI8jQUO5STjnn+igGacevpoJVdCOt2VCEMR2jbWVtZJVnXQHIpoTpc1K3pikDBya6r+Ukp
 Lik2l+JSJYPXVowE8vcLv6ilgvjsX8YkeN0fk3JPtgKJBSyqtc3cXSpg6Zucc8WKBjFyj+L7
 CqsAE8V9bvXvos40NjVnqTa/Y2nJOtJGBYIFWfs67vrZzLR+XCuwNMbXeuFIWLdWWfz9Pnwb
 OlZ1ailYvgAgUoMrId2VbpmlPps69zqrr5c7wJlAHSSMwX1UOw9eCHe0JkdrLBJy59YpRCyB
 BCF9O5aDrPVasnrJ1gceVg+ZeOZ2PBIwTTfsaYvLEPh6HMl9baLSxwLbRyLlTAbM7Z/do8om
 L9ztMkT4g25qxwrLtff0nEKrTvRdCRYXvV1rIweDa/qlhEvlANIb6vcPSmqspuBXNNBbxsxK
 TiOiaue3LlRyyIuqZbo+aQhAAacuXgPhPyO5FoFOkjPhdfPwPM6tPGUHfLbUSwNpiirEcoqU
 oSoC6GxDbqD9XFkiaCvmkiyThpZCkTxFlPZkjM0ea6wc6VsfnPAJisxNI5hOazfH310JlBmw
 V1T9IopvfsGsi08MuvelHOJc8DecOE=
IronPort-HdrOrdr: A9a23:Swiab6+dNI7l1DZAn4Buk+D8I+orL9Y04lQ7vn2ZhyYlFvBw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObeEYZmIbsS+V2njbLz9t+ri6GLvDv5ak856Bd3ARV0lYhT0JdzpymSBNLjV7OQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="9019534"
X-MGA-submission: =?us-ascii?q?MDHuWauoB4++rwFse1+3Rh0qc3M+E6myitATWJ?=
 =?us-ascii?q?oAU0BEKQ3twILs7IpJ+t4TvPQANkJb23LI1FRHv9IOOy1H/dRysLw1mn?=
 =?us-ascii?q?ANvG+GofLWBjkIkEL5tM0HO6btuEH36qVlX32wNdeqTGsCuM5M9XRrQH?=
 =?us-ascii?q?DnIx70CQ5lq5jYoQM6z+b1vA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 12:13:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1647688387;
	bh=gVhRSYi4A+Q4/L1SG8dTnDeTZhjRDgimHzhMFi1zOXE=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=HzRSlQN8+jrkrfZaAauE54QN6Hs4G2lWxuI10cHZI/nLpKNFdaNijN7JGmnTpPym6
	 Eb8gzo+ah+m0+FLchpfIc9I+avGLneh6JpVdMQtt4hCys7aJdAPdJmHVSWOMPHPL9p
	 j7FhEhlrE3ezh7nfOsTNW+1qMWRPLCq9HlZzO+XI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.182.172]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MeUbo-1o3Un91cnM-00agVm; Sat, 19
 Mar 2022 12:13:07 +0100
Message-ID: <e7182c14-5551-111d-7c41-16fb747fe505@web.de>
Date: Sat, 19 Mar 2022 12:13:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Eric Wheeler <cocci@lists.ewheeler.net>
References: <a2422ea-5dd9-753-cf9b-97439e7db462@ewheeler.net>
 <75237f17-66ae-21c3-8796-c656315d99d0@ewheeler.net>
 <db684d7-8b40-d3be-969f-cb399e39d4c3@ewheeler.net>
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <db684d7-8b40-d3be-969f-cb399e39d4c3@ewheeler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Qzy3RRw+J7FRdAXOZ50N3UjIF+mjfD+42EmdmMItpThq1UfX67D
 M7Nab3bZW6JYgefqB9zIXrsdvslJIL83SpYcbMR/nyWukrx5I6xvdsonhUiUZo0cYex3x1H
 /lfyHgbXrbibfIMcb52iu9LxJkfrLjc8WfvJbP+l5cOjTtLQTLDxr/pphymZh3XB4EuQRgp
 YpKcnnQ/MIXHGnT1b85qw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ppLY2xMa++E=:Xg/cPj+zutIEOjSMLJa87C
 nxujIY/WYtVz58v2G7ERyYe5rdJW89nW230hUbbSUjB/RetTKq9bkN0HXCZGfNzNa7bt7XihN
 yLWTaxOE5Foj7s4sclKekBwd3jN2TlqgJV5tzO+dD2AwjmaSP9suS9cNU5iPGOhCIfEOlhmDA
 cImjxEXibh+AXsOFJXoH/Atdp5vOQ33oYmjODzme41p4RivAq+ITlJ61YWUfJVhB9JoOSbIms
 bWeJTZA/9ADnT+UNEacmJQi4mABRls30bi2ZERCdmbrrurmmPEDiDqrTUG+5qV1xwqxtQe0NX
 DY8CAMmkl184MNQbEI7Yf57Xb5jJI1DqwXXIRQFAY0z07np2SE4QG1cFhLII87FaIEgDNx8Ie
 Eg2Qx/sAenpChSANtX5J9EfPA+YPxTkJboB9FimscAPNZSdkWA0HOpqOJPwyBNkoFv9hcaltS
 ZKPnS9/hbp80NFvux7tb/ULihYQShYru/BtJog+TgCyN+aFdF5YQt6BgV6TdegvWIzXDEtGJT
 S3sKAcyVDh/kSiammrwC0SwaoU29KiqH0GQYewnshnR5dSImfteRq4qFLEgGCOlfr2jURd/8j
 IHZ8kRNHTdYlzCmmuSZEqeETVso1okP0eZvHFjevBbzany2LVwDs0Sp03E9RCbv/1npkqcckw
 41TQu8pSw04oFdyrjhieZPtb5zfiBKMdi2sDnX1k4Dhrc+uAKdUcVpQuER7gufOWHA3r68Mgy
 f4MsqMKM9nV7dU2c6qsDZfIbh2yt/IJXFLuU1P7yayirFLbboNa8vNWiEIa7pgXS1MloaF3+E
 +UEYWoY7r4czPbBuzthSZSDJcHlK1ZUcDc4KHBSzDWyYXW5kSY4rQBdsmitQYH7n/SXrMvxkb
 PjSmG9JWHmB37rL7Zeyby+AAPgOsDMlBZ/IGyLh5AZsxkPkoJS/y1bt3BamDoCjwA38BVYLyt
 DZBQbQ7g9QEtlpYM9X1Ctghpru9686n8oYdzVUzCDj7UPHkQ2eceuiGtDDD1ZG1KEMrzB8Mtu
 BenSDgk2qYUwsFhvRiBVTCq1K7FGuM9HN3u2czjztGptz/cW0zCl4NyaPzp9kbQHRRrXTjG+c
 mTtLwz6Bb3XTTQ=
Subject: Re: [cocci] Can fields from structs be used added code as
 expressions?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 239
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/e7182c14-5551-111d-7c41-16fb747fe505%40web.de>


> I am continuously amazed by what Coccinelle is capable of.


I am curious how your development interests will grow also in this area.



> 	// Add the compare_T() function call and compare_T function definition =
for each type:
> 	@ r2 @
> 	identifier struct_name.I;
> 	fresh identifier FN =3D "compare_"##I;
> 	@@
> 	f()
> 	{
> 	++  FN();
> 	}
> 	++void FN(){}


I suggest to reconsider this SmPL change approach a bit more.

I doubt that you would like to add only a single function (or macro) call
within the implementation of the function =E2=80=9Cf=E2=80=9D.

See also:
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/20fdb67f4b20a242f2223=
37e13091115884cf6bb/docs/manual/cocci_syntax.tex#L1318
https://github.com/coccinelle/coccinelle/blob/ae337fce1512ff15aabc3ad5b6d2=
e537f97ab62a/docs/manual/cocci_syntax.tex#L1318


Are you sure that the specification of an empty function implementation
would be appropriate here?

Regards,
Markus

