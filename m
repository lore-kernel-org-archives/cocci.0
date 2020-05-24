Return-Path: <SRS0=Qcbb=7G=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF5EC433E0
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 12:02:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD58207FB
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 12:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="WfGOjrjl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD58207FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04OC2d98025034;
	Sun, 24 May 2020 14:02:39 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E4D983DC8;
	Sun, 24 May 2020 14:02:38 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E37933D0F
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 14:02:36 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04OC2auP024772
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 14:02:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590321752;
 bh=0eSX/cHiOFruedHKB8swa09KBon8gbJrqCmTLrOAiKk=;
 h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
 b=WfGOjrjlZdWYsaImbQOmVVIEBHoqTrwdDXP/YLq9zybvXfPXbtt4KXmSddEneYe9U
 T7MC4JngIZldquu0AaRLwEM6LhEQrGEMivxDmDpXxa8Alfp51snTpyvXsX/k8+fNg/
 nC87TWfSMEcGoKsBuJ+/5obm5K6PU0Vxdgrtzz98=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.187.46]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mt8kX-1ikBTl1q01-00tPeF; Sun, 24
 May 2020 14:02:32 +0200
To: Julia Lawall <julia.lawall@inria.fr>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1d595042-0940-3056-5460-bffd58782fe2@web.de>
Date: Sun, 24 May 2020 14:02:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:zq7Wa8CjPj7UUMF8R42tqMjyl4puuIye4OpG5TeZrR70WGQiv9U
 R8HX++6Cn02mIV+0/phSfcC8aq4s1OnSNeSsCDdkTO901p2glUuoOrUi0Rg4QNDY7o/pz83
 FT+RQYHg5OsGB/xxDurEQFt7usWUl3o7J/O9H8wEP2tDWA8KkN34JJHi3m9bUPHOU9LjtWq
 UK87MupLCZCFYOqLS+k0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1MsnaKV+qr4=:EGe/Bz6wjIlef+8Rb6CdGN
 k2CsVYCOe8Bq/RSMOpaGJltAfA3W0MzgSXOlidtzY5apV6xVAlYEVkGU4gUOwU/ZCOxoEG2LR
 sbMpfsb53Toe7BRR+RuSjwiU0tEzd7wVC8hKeyI6jwTUM0YSLB56JOcUnGjm7uz0VkT88fOg/
 SSyAlPyW3VM6JO9VmzgM9K+WiyIXDTi4c4VZqT2ZpybZJrCy2xM9zOi+NHXS+3xOFhJ1gGy3x
 R2Os5T9u6p3cktWI+wAOch3fZOVJTeNIwoxBZpWJ+yDo6CjsJJcAdoBMMRf1w+ZFLmRTJu27b
 Z14+MYQD1ZC0S/NTSmiKMMHBQGgtL34nI5zvQ+OmRSY4OLAjPyMP5RyhNjlXkRt7/Mc2MoYzv
 vHPy4dBj4XvNR8+dvA2x/dOikdUJkzL7F4BIk9nW+YAMORjM7WBm/0seIp/pNJR1dzIYJqvn3
 YqLwKz5PLHludZY4d8DsLE1sUtsBsEfUnxcVWQB09HQ2M9oWiPPDgYpLodDQJCgbA6oYtACk/
 yTVAovxaDhYwRz+9cEjCJdG2QrVNVoQCq+yHg6NSiuFjNWtp16Myy/8XHcDCA/CF8bdgMYayi
 zJcVuWjTspvi3jCXY/vCSIgY03kxFNkX8Ipy6Zc3pYue7b2yQcbNFEYwPUF8dCCo0mCVVMvKT
 UWIvUHjedfqGbO3Be4zwuniSLyY+g4LBIC89lHUmb1ep3wbe0YyWGy3l9jY1XcvBOXIaSEYVL
 GqK0I9aemggkDcsS5k4eSljjtQpm3H7K32DfCJUYWfJ7awsDMrSTuiFTBZfWMcdEeD2pMmcLo
 UYOyCLPOeNaGEnY3Rdawaif78t0JlV4noB3MmwVVCWDtOmr1U3MTaSZsnbB4qf8yo3YwIWnDc
 X2CqaymYBpA6jLRw1ctmYOyWUwI0p2TrYRDDWJj/uFyj4n0fL1ER1Dj5ufjTFBRwu+CK8Aoc6
 G8Hta8Dd+lkQ8GnNF9QkJCZw1rB+y41pXkHsl+MJwjhTH1pUAccYSB7MgWX0yK2J1ddwef5D9
 kDMbIiIOQxujd8bUmoTTKs6LZu+GKbJYkj+dTOKf0P2oEm4wmCfrYg4w5XluLrFARGqYYB0m5
 afGyUtzxZSNWXdY/pdCfr2YYof8PNgDD75QpdBaq9L7dFH4YmULuZRW8QpDNFNJzf1jMVJkol
 81n2yere/rAvYt56QkDAWLzLZjvu9QwQaWtIMXshjgbOjEwAf6PxML4HHCsi4MzmB7Hdfm57E
 JhTDYQBMBZIf5a4HP
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 14:02:39 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 14:02:36 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Converting variable initialisations to later assignments
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

PiA+IEkgYW0gdHJ5aW5nIHRvIG1vdmUgbG9jYWwgdmFyaWFibGUgaW5pdGlhbGl6YXRpb24gb2Yg
c29tZSB2YXJpYWJsZSB0bwo+ID4gZmlyc3Qgc3RhdGVtZW50LiDigKYKCkkgZmluZCBzdWNoIGEg
c291cmNlIGNvZGUgdHJhbnNmb3JtYXRpb24gdGFzayBhbHNvIGludGVyZXN0aW5nLgpCdXQgaXQg
cG9pbnRzIHNvbWUgc29mdHdhcmUgZGV2ZWxvcG1lbnQgY2hhbGxlbmdlcyBvdXQgYWxzbyBmb3Ig
dGhlIHNhZmUgYXBwbGljYXRpb24Kb2YgdGhlIHNlbWFudGljIHBhdGNoIGxhbmd1YWdlIGZvciB0
aGlzIHVzZSBjYXNlLgoKCj4gcHV0IFwoPCsuLi5hLi4uKz5cJkVcKSBpbiBwbGFjZSBvZiBFCgpI
b3cgZG8geW91IHRoaW5rIGFib3V0IHRoZSBmb2xsb3dpbmcgU21QTCBzY3JpcHQgdmFyaWFudD8K
CkBtb3ZlbWVudEAKZXhwcmVzc2lvbiBFOwppZGVudGlmaWVyIFYxLCBWMiwgVng7CnN0YXRlbWVu
dCBTOwp0eXBlIFQxLCBUMjsKQEAKIFQxIFYxOwogLi4uIHdoZW4gYW55CiBUMiBWMgotICAgICAg
PSBcKCA8Ky4uLiBWeCAuLi4rPiBcJiBFIFwpCiA7CiAuLi4gd2hlbiBhbnkKICAgICB3aGVuICE9
IFMKKysgVjIgPSBFOwoKCmVsZnJpbmdAU29ubmU6fi9Qcm9qZWt0ZS9Db2NjaW5lbGxlL2phbml0
b3I+IHNwYXRjaCAtLXBhcnNlLWNvY2NpIGNvbnZlcnRfdmFyaWFibGVfaW5pdGlhbGlzYXRpb25f
dG9fYXNzaWdubWVudC5jb2NjaQrigKYKcGx1czogcGFyc2UgZXJyb3I6CiAgRmlsZSAiY29udmVy
dF92YXJpYWJsZV9pbml0aWFsaXNhdGlvbl90b19hc3NpZ25tZW50LmNvY2NpIiwgbGluZSAxMCwg
Y29sdW1uIDksIGNoYXJwb3MgPSAxMTcKICBhcm91bmQgPSAnXCgnLAogIHdob2xlIGNvbnRlbnQg
PSAtICAgICAgPSBcKCA8Ky4uLiBWeCAuLi4rPiBcJiBFIFwpCgoKSSBoYXZlIHRyaWVkIGFub3Ro
ZXIgU21QTCBjb2RlIHZhcmlhdGlvbiBvdXQgdGhlbi4KCi1UMiBWMiA9IFwoIDwrLi4uIFZ4IC4u
Lis+IFwmIEUgXCkKK1QyIFYyCiA7CgplbGZyaW5nQFNvbm5lOn4vUHJvamVrdGUvQ29jY2luZWxs
ZS9qYW5pdG9yPiBzcGF0Y2ggLS1wYXJzZS1jb2NjaSBjb252ZXJ0X3ZhcmlhYmxlX2luaXRpYWxp
c2F0aW9uX3RvX2Fzc2lnbm1lbnQyLmNvY2NpCuKApgoxNDogbm8gYXZhaWxhYmxlIHRva2VuIHRv
IGF0dGFjaCB0bwoKCkhvdyB3aWxsIHRoZSBzb2Z0d2FyZSBldm9sdXRpb24gYmUgY29udGludWVk
IGhlcmU/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpo
dHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
