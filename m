Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF179CF9C64
	for <cocci@archiver.kernel.org>; Sun, 22 Sep 2024 11:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=OBzZirTmg9Y583zmQG9vtRR7qVH9KayJffqRO/GsoSY=;
  b=uJuaT8wLVIIN8p9AxrVKR+vTy5y0tARXZVY+FW95xuCf1lKA6sy2qgW3
   qyIjSpK3CGTa9xrycF5LQlZz69bLqOEHxiI1AVmVezz9/l6rGBL08CgXc
   JLMMx7X3u0U6fJ/Gc6G783yMLx60NP6CEUaiWcveGgthi/MheEJZ6qkK2
   A=;
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
X-IronPort-AV: E=Sophos;i="6.10,249,1719871200"; 
   d="scan'208";a="184416148"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Sep 2024 13:36:36 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CA8A2E0145; Sun, 22 Sep 2024 13:36:35 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4AB31E00B7
	for <cocci@sympa.inria.fr>; Sun, 22 Sep 2024 13:36:31 +0200 (CEST)
IronPort-SDR: 66f0013e_U9ubdd6SWL3LKmKkNfWx6SZKJc4UpStm/dW1cU2E9Yxc4C1
 /2AEkypCJ2gZvw/YKs4F7p/ZwYg5EBpbLspy+UQ==
X-IPAS-Result: =?us-ascii?q?A0EhAQCg/+9m/07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYJDB3YGVDMEC0gIJYNtPIgdhzCBdTCEO48OiHaBVoFAPg8BAwENO?=
 =?us-ascii?q?wYBAgQBAQMBA4FJgy0KAneJDAIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQgBA?=
 =?us-ascii?q?QUBAQECAQECBAYBAoEKCAuFL0YNgmMBEHkbdDACAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBFwINOkQBAQECAQwXHQEBEScPCQIaAiYCAlYGARQBAYJ9AYIvAQMOIwcNB?=
 =?us-ascii?q?pd4nDeBMoEBggwBAQbaWh8sIleBYwMGgRouAYhKAYYihDsnD4FVRIE8gksHM?=
 =?us-ascii?q?T6CYQSBXoNbgmmNIIRtghCFVIQKJYhicJBmUnscA1khEwFVExcLCQWJOAqDH?=
 =?us-ascii?q?IFuJoQVCIErE4NfgWcJYYdnYoENgT6BWQFGgnNKg1AcgV0FOEmCUWtOPAINA?=
 =?us-ascii?q?jeCKiRqglqBLwQFg2odQAIBC209NQkLGwY9q1+BW0iCP4FBCYIEO8RcgQo0B?=
 =?us-ascii?q?4I3gWOBYwyKJ4NZkVIGEy+XPg4GknOYdiKNWZsigWc9gVkzGiSDNlILDg+OI?=
 =?us-ascii?q?YN6M8ZaQTUCATgCBwEKAQEDCYVGAQGGPoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:/M0JJq05Fq56t6euafbD5fxwkn2cJEfYwER7XKvMYLTBsI5bpzVTm
 jYXCj+PP/fZMGKnfI8la4rk8RkO6J6Dz99gTAps3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/vOHNIQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwa++3k
 YqaT/b3Zhn8g1aYDkpOs/jf8EI15qyr0N8llgVWic5j7Ae2e0Y9V8p3yZGZdxPQXoRSF+imc
 OfPpJnRErTxon/Bovv8+lrKWhViroz6ZWBiuVIKM0SWuSWukwRpukoN2FXwXm8M49mBt4gZJ
 NygLvVcQy9xVkHHsLx1vxW1j0iSlECJkVPKCSHXjCCd86HJWzzzwMhTL00RB4A39bhmHWRI2
 vAeCBlYO3hvh8ruqF66Yuxrm9hlM8Theo8S0p1i5WuAUrB5G9aaEv+Muo8wMDQY3qiiGd77b
 tAadCEpQRDOeRxJNX8IBZh4kOrAanzXKm0E9AvL/PZri4TV5B570IjwGcLNRuTQe9QIm0G+u
 TP3pU2sV3n2M/Tak1Jp6EmEgubQlCf/cJATEbei/7hrhkeSzyodEnU+XlywqviRkV+7Q9sZK
 koO+yNoo7JayaCwZtz6QgH+v3OO+BIRMzZNL9AHBMi24vK8y26k6qIsF1atxfR/3CPqbVTGF
 2Nlnu8FwRRqt6CJD22Q/PGYoFte/MTTwXAqPUc5ockturEPY73fSjrQQ9wlHKPdYhjdB2Tr2
 z7TxMQhr+x7sCPIvplXOXjYjjjqqpWhosvZIOnIdjrN0z6Vr7JJq2BlBZY3IBqAwEukooG9g
 UU5
IronPort-HdrOrdr: A9a23:N6yvDqp7D1i8stO/5m3CvSkaV5r1eYIsimQD101hICG9Afbo8v
 xG+85rrCMc6QxhPk3I/OrqBEDuexzhHPJOkO0s1PKZLW7bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGttdBktCazpyCSdNNXF77HcCZe
 GhDkErnVCdRUg=
X-Talos-CUID: 9a23:NuVwoGOnbkmns+5DHzZkyXM3Fucff1LSkmbMJkmXBWBJYejA
X-Talos-MUID: 9a23:atVcZwhtJGyYiTdFNti4zsMpJs1o07mHEFgxqc84qpSBMgpvagbHpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.10,249,1719871200"; 
   d="scan'208";a="184416144"
X-MGA-submission: =?us-ascii?q?MDEsVw8cmVNokmNf3j7zd1BVoAi4RlIdpNGTtP?=
 =?us-ascii?q?642JjVmgGnJRq846AU+yrOI92ilvkRKmPjNX57CR5r572w01GwQf+MTe?=
 =?us-ascii?q?/k+rXMEa8pan+9CpbDpkwXRRWZDrSOmsGUOI5QpHz5r7c8qdBpzVInA5?=
 =?us-ascii?q?FmqkbDmILqENGShSrREZgonA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 13:36:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727004980; x=1727609780; i=markus.elfring@web.de;
	bh=OBzZirTmg9Y583zmQG9vtRR7qVH9KayJffqRO/GsoSY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HSW+ziJaqQtyyWYi81g03JYwDV5MmUgGcUmvaSAHVhHXvkwfHAOmkIR+YOKb+Rch
	 8GoHLfgoS3VNLr9Zn0LwmP4seAoq7SA9gntkERVZeDhd+7hdWgAi9aMPf9w07GmkD
	 GjmlZx39vU4EQoqDCxoftInam1M1oYdAoP7+dDFMOiz+pGFcr0UBZBbFZKoaO5Af2
	 tTo/mRVDq7UHus9NRMD2sJwLh8G7amBs9dLZQ19nfWOIvcPf8gNMOcBne35HbGQuj
	 +p4i2IuRRheqDuOehHpCKitThi7T6Yc04IyRPXx8rGQgn3pz3Vdjcy5Wtz8tLyRF1
	 UaS5jhD7YuhD50YPig==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0Icn-1rzIHs3u4N-010BXV; Sun, 22
 Sep 2024 13:36:19 +0200
Message-ID: <d2d6b276-0f4d-43ea-86d6-6568b79f58ac@web.de>
Date: Sun, 22 Sep 2024 13:36:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <46260c9a-4c82-476b-85a1-a4174709c5bd@web.de>
 <alpine.DEB.2.22.394.2409212209470.3471@hadrien>
 <b1872e36-154b-477f-907a-7fc98b301931@web.de>
 <c2b0fc58-a399-4376-a4a4-2f7a3ed219f0@web.de>
 <alpine.DEB.2.22.394.2409221148130.3517@hadrien>
 <5073d921-72a6-4992-97bf-36a7b792b7c5@web.de>
 <alpine.DEB.2.22.394.2409221321131.3517@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2409221321131.3517@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y84hctTjPkht8osYrD21vF3dqftZ0eKeMO3Uyq9qza9Q5HFO/kS
 0Dj5W6Ty8Cid9qgoKznBK8v86HHdpY9/+J4D3IzTAy1BELsmf+tJC1zaXBuFDyDUkhLzoac
 9xz2sKvD2u3iI8Lug5X1/SAkeQzxMdMxwaVzuNOcw8zrzKBTECMdRii4hVp0y47xheqxZ7R
 9zk7W5/0VVZuTA3DPenlw==
UI-OutboundReport: notjunk:1;M01:P0:/yZAi6oc5S8=;K8YtrLq8fpcEPfmNfnQIkvpbXZQ
 ShSI01C/cvT3QD6JSBF+ta7Zma8jW3wXocOfD+izSnxOf9MAFXHLbPUDf/oC0gATvqPHUaohP
 1lc8WMIcFa63pjQ0S5HrZ6z63GVhyb6QdqmpwZzYMy6iNguYGTdNT8zyNI9Sw3ikgfiaae1vs
 bvTeonsyphV2vqybf1HKUEW7GA5iYXRYCTIHp03cFKSLBxrLVrhC37lr3HQg3Lr/DfiseaosH
 77Dp+1NhJGyNdgs2RzdFfAxg0HaZslrhswKxdJlmsN9gPRg7otwCPLvs2O9FJh5rAQQ+XRvuf
 rxHs9cnoavtGruLvODbst5Y/54W/bapcr17QYt/jcRoPK2Aq4UrTP0lsKbVlmHEXDYdBDWhpU
 28JLqpNhANeacz+XIBvqGek0v1/ZM+dGxWDVCJTUus2XkdNpEZr2d8PPd/ETVob+dAUZYyCmq
 9jjPY5VFQbHmgKR4BoDdzwh8DZ1yQi+TCsmSteSBWRK2URk90ryXRJnmDhuNEkQnqnwxflw5w
 v82cI6F7tb96uQMZQCW8LjWduwaSc/RrDcvGe7zvRLTzhM6lR/rIHwAoYOM+F2LHIPfngqL82
 oigSOxhk2eAnxk/b3p27yaHcQd9nIdi0ci48d5T1p+A3jLQnGbDUpVDlTOnak9JQ2QOYtPyIQ
 5u4k/2Goz3N/Tv4eIXJuOX/83+aF0H9ZUwKbGY1XR777xWFRc9LjmuS0N2+/b2O8UcQs3t7Vq
 6AxGDlRn3wxPE/a+mAp2ktaX5EpkRRdz9ZeAK+p4ZnFF/G9RB9vGGrkfB6v4Um2/DiN9+HQho
 TrNapSWOux3JJIfuR20ccfbw==
Subject: Re: [cocci] Determining a return code variable for a jump target
 (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1880
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/d2d6b276-0f4d-43ea-86d6-6568b79f58ac%40web.de>

>>> The only match is in the declaration, but any int variable
>>> declaration satisfies that.
>>
>> I would like to increase case distinctions accordingly.
>> Variables like =E2=80=9Ci=E2=80=9D and =E2=80=9Cj=E2=80=9D are obviousl=
y used in some for loops (for example).
>> How should such control flow properties be restricted by the means of
>> the semantic patch language?
>
> You can use other rules, inheritance, position variables, etc to
> disqualify a variable that is not used in the way you like, or that is
> used in a way that you dont like.

Would another SmPL code exclusion specification be sufficient (for a while=
)?

SmPL script variant:

// See also:
// ath12k_pull_reg_chan_list_ext_update_ev()
// https://elixir.bootlin.com/linux/v6.11/source/drivers/net/wireless/ath/=
ath12k/wmi.c#L4683
@adjustment5@
constant c;
expression e1, e2;
identifier rc2, x;
fresh identifier target =3D "free_" ## x;
@@
 int rc2;
 <+... when !=3D \( rc2++ \| ++rc2 \| rc2-- \| --rc2 \)
 if (...)
 {
 ... when !=3D \( x =3D e1 \| e2(..., &x, ...) \)
-   kfree(x);
-   return
+   rc2 =3D
           -c;
+   goto target;
 }
 ...+>
+rc2 =3D 0;
+target:
 kfree(x);
 return
-       0
+       rc2
 ;


Test result:
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time spatch =
=E2=80=A6/Projekte/Coccinelle/janitor/use_common_kfree_code5.cocci drivers=
/net/wireless/ath/ath12k/wmi.c
=E2=80=A6
Note: processing took    17.6s: drivers/net/wireless/ath/ath12k/wmi.c

real    0m17,669s
user    0m17,556s
sys     0m0,106s


Regards,
Markus
