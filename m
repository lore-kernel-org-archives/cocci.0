Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8747AC433EF
	for <cocci@archiver.kernel.org>; Sun, 20 Mar 2022 07:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=cbVT+DkAdi+hgPwo2w6TIekuSuXSR9wp1c7R2maoVh8=;
  b=MaECLu9Y0+iICH7IerVIyUzEwzKAGmsMzFiIO+wWIRa5IdEgXn/5x41k
   5ttFFYajz/QkhOL7aeokf9ZTM3puD8pOlYD+IpeAweVCLmtgRtZkwGWa4
   6q4jKRA6ckgQwTdnjClI8G5dGAmTU3o3V7vlUr1oRzmotgI7epyfr2ATi
   M=;
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
X-IronPort-AV: E=Sophos;i="5.90,195,1643670000"; 
   d="scan'208";a="27060698"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Mar 2022 08:48:36 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 69457E020F; Sun, 20 Mar 2022 08:48:36 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0823AE0069
	for <cocci@sympa.inria.fr>; Sun, 20 Mar 2022 08:48:34 +0100 (CET)
IronPort-SDR: AanjT16McGL6WpViEHuANRO7dBvVBinFSc29R9GwcPV7FsZHUWQ0/HITRc7qbuhEMsz2Yrzuqa
 4rZarNkjanQ/uDDBqKx6W9uBaV3JPlTn5xLhMo3c3ETCwMYuZaAhoi8hcDbbxpPWIUJXiVrK/Q
 F8OuhNjyHvWrbYMOt7Bcu/kY5a5dKL9s6yUIpppnxyzWgAVQ1VsRNuqgjyYrrroiem+CiadhCm
 K8TbdXKLnQ6Xwd6RSlGjte5nHQC9A4jbfIMxP4tKo7Rifue+rO9C8h2luAiAc2VyqvW0RPokK4
 iABPBz0ra25xECU2M1mOhVg7
X-IPAS-Result: =?us-ascii?q?A0AtBwDj2zZihwsR49RaHgEBCxIMQIFcgiZ+VysEC0SEV?=
 =?us-ascii?q?I5zgiUDhB+OHYoogXsLAQMBDRIBASUFAQIEAQE9gVWCdQKENAIdBwEENwMNA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQwNCQUICgcOEAU2B?=
 =?us-ascii?q?l4GZASBSwSBdAs0DYI1KQGDZAECAgEjHQEBESYBDwsaAiYCAlcGDQgBAYMAA?=
 =?us-ascii?q?YJkAQMNJQutY4ExgQGCCAEBBoE/ARNBgjQfLCJSgVsDBoEQLY1OeicQgVVEg?=
 =?us-ascii?q?TyCUzA+gmMBAQKBXoMagmWYDGgaEywgD4EWFcEVNAeCEoE6gUEMiUKUTwYUL?=
 =?us-ascii?q?pY9DgaRbR2WPo0VlDyFMYILA4FoMxokgzhOAQIBAg0BAgIDAQIBAgkBAQKOH?=
 =?us-ascii?q?RmDWTOBC4khQDQCCS0CBgEKAQEDCYVHAQGMKQEB?=
IronPort-PHdr: A9a23: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
 PLmr5dEWVZzGv5IUixY
IronPort-Data: A9a23:1aGzdKxQ9WkU+0aabqZ6t+cUwCrEfRIJ4+MujC+fZmUNrF6WrkVSz
 WUcXGyEPvrcZTH9e9t0PI608E1UvMeDnNVkHFZvqVhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefQAOOU5NfsYkidfyc9IMsaoU8lyrZRbrJA24DjWVvW4
 4uq+qUzBXf8s9JKGjJMg068gEg31BjCkGtwUosWOJinFHeH/5UkJMp3yZOZdxMUcaEIdgKOf
 Nsv+Znilo/vE7jBPfv++lrzWhVirrc/pmFigFIOM0SpqkAqSiDfTs/XOdJEAXq7hQllkPhxk
 +0Tu4CgcTsvI6rww+saUSh6MBhHaPguFL/veRBTsOSWyFDaNWThybNiASnaP6VCo7wxWzsRs
 6VHbmlUBvyAr7reLLaTb+B2hdk4auTvMpkevH5I0jzTS/orKXzGa/SSuIYJhWhYasZmFvjwT
 Oc4Sh1WUjfvajpkAEkNLqIYg7L97pX4W2QF9AzM/PRfD3Lo5Ah4z7HpNPLHe9mAX8wTn0CCp
 2uA8X6RKhodP9ee4SGU92qlwO7JhyLyHowIfIBU7dZvh0CPgHMeAlsaWDNXvMVVlGa+AOoBJ
 VAEwhYosK8Or0OsTOjffCSB9SvsUgEnZ/JcFOgz6Qeow6XS4hqECmVsctKnQIN/3CPRbWNwv
 mJlj+8FFhQy6OHOEy71GqO88mPraXJ9wXoqOHdcJTbp9eUPt6kfo3ojpP5GF6iph9f8BCuYL
 9ui8XZi3u17YSIj7aW2/FbDijSg46DHRwonjjg7s0qg6R5lIpGobcqk5DA3DMqszq7JETFtX
 1BdxaByCdzi67nTzkRhp81TRdmUCw6tamG0vLKWN8BJG86R03CiZ5tMxzp1OV1kNM0JERewP
 hOM5loNuscLZyHxBUOSX25XI5t6pUQHPYu0Ps04kvIVPPCdiSfaoHAwPhT4M57FyhV2zf1X1
 WinnTaEVCtGV/0+klJats9En+ZjxyYiyHnVSIyzxhvP7FZtTC79dFvxC3PXNrpRxPrc/m39q
 o8DX+PXlUk3eLCgM0H/rN9LRXhXfCNTLc2n+6R/KLbeSiI4QztJI6GKntscl3lNxPk9ehHgp
 SvsAie1CTPX2RX6FOl9Qis6Oe21Ason8y5T0O5FFQ/A5kXPqL2HtM83H6bbt5F+nAC65fIrH
 fQDZeuaBfFDFmbO9zgHM8vioYYkeBny3VCCOC+sYT4eeZ98RlWVq4G+IVa1rHEDXnitqM8zg
 7y8zQeFE5ANcARVCpqEYvyYyV7s72MWn/h/XheTL9QKIBfs/YFmJjbflPgyJ81QexzPyiHEh
 RmbC1EUqLCV8YMy9dDIg4GCrpuoSrcvQBAFQjODtbvvbHvU5Guux4NEQd2kRzGFWTOm4rima
 MVU0+r4bq8NkmFKhIwgQbxl+qQzuon0rLhAwwU4R3jGYgj5Cr5kJXXaj8BDurcUn+1cvhaqH
 F2C8J9WNOzRas/iFVcQIisjb/iCjK1FxGONsK5teEiqtjVq+LenUFlJO0fegiJqLIxzbNEvz
 9AntZNE8Ae4kBcrbo2Lg3wG7WiKNXBcAawruotDWd3ujRc3jE5Pa9rQB3ausp2IbtxNNGgsI
 yOV3faT2e4DmxCaK3djR2LQ2ed9hIgVvE4YxlE1J2OPxojPiMgx0UAD6j8wVAlUkk5K3u8b1
 rKH7KGpyXhiPguEhfSvm0ipHBxdQgKU8Ar9xjPlUYEfo1aADgTwwK8VYI5hP3z1N0pDczId8
 LzwJKPNT2PxZM+otsctcRcNlhEgJOCdMiXdlcrhE8nt81zWp9b6qvfGWFfkYCcLzS/8aIMra
 AWqECtNhXXHCBMt
IronPort-HdrOrdr: A9a23:99UAcaptR2dPYBpdPYYm7yEaV5oPeYIsimQD101hICG9vPbo8v
 xG785rtiMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaWSS5vyb3ODXKadD/DDKysGVbfy19QYXceiGUdAb0+9BYDzrb3Gfz2R9b6YEKA
 ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,195,1643670000"; 
   d="scan'208";a="9051917"
X-MGA-submission: =?us-ascii?q?MDHYeER++Kx1VZzjeL9DpwUCT9+3Ydt254TwAn?=
 =?us-ascii?q?ljnbe4qB+7L7zvzLV/PqUg8FkqOnYqdNGC2ohivu0gnFjq+PJO0fT5+N?=
 =?us-ascii?q?d5fiEVlDVLbF0vGe/cfG8okvA+9lll3yq2xfQ9sdPukVO5L3ek24Ozuf?=
 =?us-ascii?q?FmHzBE2qqY6M1VM06ZTkr2SQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 08:48:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1647762511;
	bh=6ENuWt0eUUrZAchMcWUf/DCF7vlNnqJJUtIj9seO0jo=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=O6hyFge1PZlTL23RREw8u7V9ciXg6+kazp9wj9YtN5yRSjx7U193d4/kXJZiHuChw
	 bHV9l2F0aWlml6+RoQfNEuxMttO+XBJpP/cPvK8qQMsERR2IDGAxmanujOpQn52GGu
	 Jp7YzHCd7grfge71xsQuSNoGB7M7+2BconafDu1c=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.118.49]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mpl0p-1nt5JC2Fu1-00qA0D; Sun, 20
 Mar 2022 08:48:31 +0100
Message-ID: <ad4280e9-4b24-0dfc-8ce6-b03ab68b1e28@web.de>
Date: Sun, 20 Mar 2022 08:48:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr, Eric Wheeler <cocci@lists.ewheeler.net>
References: <30124bde-34e-65ca-d5bc-fc3255ccda3@ewheeler.net>
 <alpine.DEB.2.22.394.2203190922070.3204@hadrien>
 <66b66e5a-c024-7d0b-c84c-d780d5ce41f6@web.de>
 <6a41b56e-84bb-ead8-87c3-6d2d4421df7c@ewheeler.net>
 <alpine.DEB.2.22.394.2203192110540.3204@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2203192110540.3204@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qanJeNjd9dcE3AmUS4bsfhypxbWQBZXsz/R4tVBjpRY83PMLcR9
 tET7HBjn+r11zBc5u1cFCsR86Edoakq4jPrf7unER9P72z4x4684xEhUIp8l37xDO6oGD6x
 S86IOZLc93/FP9j3wY/f0BGqqe7MpXxjfOhXWXRWR0L/cSMIuIciXBOKb0QQpEn0cgEqXQg
 JopgfMUJW/78VxDaeibHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i9p2qWLhhec=:QST0LI8g3BMqQyXBUWGhKU
 g4XJ7aFCwXYogWCpf5adp65yOQcUiapTrxU1Bd4w/IC82LkhR/GeikSF9LMKgyVgTo7pJs4qz
 JYk5xzcXxBv7Q6gNbQYZJoZzlYRuxUkGunkzblkd+nE50kXrLd0nsMW8iUnjtj/yJL37o6toA
 CnsuZ9Fx845ObjoheFOkRwgX4EPzTbl4vRTNbAvHk0b4EzX/rRcb3EuqaeSk4GrzjIocfZZPj
 57XSSSbrvMZAVf/RVuZc/oXSLoNCuwVL3un8PjfaznNuE9upIjqAFz6e0j/w0j6df8mO5HLJI
 om343ljobqPcjVnBw89CMir/L7NVnB0pY/CIZpkdNUN7h6sSpy6IV2TrdY+Gx9EJacfpvyiC7
 4L6t1p48u2lY23BQujyccO2V4noxF8zO6CdAh5Rn+2DNVu3zSy6YvFyl6O0XNwzpJOQDIj/EC
 krSqibo2sQrfvLinfIBwVVuOxG1BYqF6nyDiwXTp+dSjUMAjbejRqLmt6WIzTwhFLCmSIT5ZC
 FIzLoYU7XL56//EpseoTYD5vIVcmDKk3oTcxbrJTO+Ss4cszdcJqSyw42TbQQnp/tf6JTx+WF
 iSjxPPO1g75a3NKkgdrmrr7VDCK+2hm7eW58/Eu8WRoEBZwTpjbHcikZpL0CeOD0EKaI695RF
 J47xni3MR1JgPkncrvyP5N45cSOxKpGpUimkHJZwRIdl934Z6HT6gcwCN+Y3TzM1HZ1sk2Kcv
 FlUU2x9VfxUvjraUdtHRluVXL4Bta1V6Os4asq/KY7e9H/8NnUlmdPQNUw6ZJM32ZUf7BB+Ro
 zxsQyM8b7QZGtP4wBxfrotzb1KgpUja+XYDdC/f650Ak4HYpEHtlAUeIZGZ7QbtnpxH3YqKz9
 pw6cXjwVrgMM+xixAjG1lMVII59ZTxSD0zJnrB25RQHJZsmDEFgCE8M0kbMVIFQSB3wy539Yf
 UqcKm+T+g754r+F3cs7XYKr7M4fJB7JRh2oUqyax4SyZL9PSvcLNTiFV+J/fsBz+cJCzg65c1
 vS9vc22XTLLTdvqIigiSpZi0omOOgekQP2l6CQYCxsBwRCDzAakj0RIP/CQczBG/2FjWG05YD
 oCo7jBny+/5FZI=
Subject: Re: [cocci] Improved error handling for mixed SmPL data processing
 indicators
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 260
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/ad4280e9-4b24-0dfc-8ce6-b03ab68b1e28%40web.de>

>> A friendly error like "You can't mix * and + in a single semantic patch=
.
>> The patch you get would be strange" would be useful ;)
> This has been fixed.  It resulted from a well intentioned but incorrect
> attempt to provide file names and line numbers for this kind of problem,
> which resulted in discarding the actual error message.


Does the commit =E2=80=9Cdon't throw away the message for a lexical parse =
error=E2=80=9D
belong to corresponding software adjustments?
https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/43f8e0e3c195870cb43=
548e5bd350aaa720f2561

How do you think about to add a test case for this issue?

Would you like to achieve any improvements for the software documentation?

* https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/20fdb67f4b20a242f22=
2337e13091115884cf6bb/docs/manual/cocci_syntax.tex#L1207
=C2=A0 https://github.com/coccinelle/coccinelle/blob/ae337fce1512ff15aabc3=
ad5b6d2e537f97ab62a/docs/manual/cocci_syntax.tex#L1207

* https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/20fdb67f4b20a242f22=
2337e13091115884cf6bb/docs/manual/cocci_syntax.tex#L1095
=C2=A0 https://github.com/coccinelle/coccinelle/blob/ae337fce1512ff15aabc3=
ad5b6d2e537f97ab62a/docs/manual/cocci_syntax.tex#L1095

Regards,
Markus

