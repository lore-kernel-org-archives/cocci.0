Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1DDD59D90
	for <cocci@archiver.kernel.org>; Tue, 26 Nov 2024 10:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=p6OdvjNK5miQueD2ZYL1KHVIq+WFp6//zIYw1L/NCA8=;
  b=iIs8VWxpPyrm8j9Qj47TOy5lR1F09gJHZmVXQKyglfteJqJXcXvypC2T
   cCeNB+UZL9WltpVg5nXW1D0As58UixPq7ouSDoIgOgGHbwLBPTWUk717G
   J/SnN+4PllFwwWl1vInBi1Qez4KGCyYyBXzvH/dWaDdsqJZaD95EgV4O5
   M=;
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
X-IronPort-AV: E=Sophos;i="6.12,185,1728943200"; 
   d="scan'208";a="195831396"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Nov 2024 11:15:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C9917E0D1C; Tue, 26 Nov 2024 11:15:26 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 77DBEE00B6
	for <cocci@sympa.inria.fr>; Tue, 26 Nov 2024 11:15:25 +0100 (CET)
IronPort-SDR: 67459fbc_k1A+slx7nypZDVhJZEw00au4BKUobbzzHiKJEOTbGDp7CX+
 ot4dIdi0bqCjRTDvkvPkS92Lwww/gA0aF7AWJ0A==
X-IPAS-Result: =?us-ascii?q?A0HoBAB4nkVneAwR49RaHgEBCxIMQIFIC4JEfQZUMwQLS?=
 =?us-ascii?q?IRWj02BdDCEO48RiHWDUQMPAQMBDTkIAQIEAQEDBIUAAopbAh4HAQQzBg4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAFDDgoxhXsNgmIBgSSBJ?=
 =?us-ascii?q?gEBAQEBAQEBAQEBAQEBAQEBARcCDTpEAQEBAgEjHQEBEScECwsaAiYCAlYGA?=
 =?us-ascii?q?RQBAYJ9AYIvAQMOIwcNsCaBMoEBggwBAQbaWx8sIleBZAMGgRouhWqCYgGGJ?=
 =?us-ascii?q?IJBgXsnD4FVRIETKYMDPoJhAoU7gmmCRIUPJYgYaIpvkGdSexwDWTIBVRMXC?=
 =?us-ascii?q?wcFgSkhLAOBeU5/gTaBUQFCgk5Kgy6BXgU3R4JKaUs6Ag0CNoIkJFmCTYElB?=
 =?us-ascii?q?AWDa4ELg16EXIYYHUACAQttPTcJCxsGPaEgR4NBgUGCepJ9j2aibDQHgjiBZ?=
 =?us-ascii?q?YFjDIonlTIGEy+XQw4GknqYeyKNXpVlhUOBfSSBXDMaJIM2TwMZD44hg3ozy?=
 =?us-ascii?q?B1CNQswAgcBCgEBAwmFRgEBi1aBSwEB?=
IronPort-PHdr: A9a23:xUodxBTXOCnw0RRCztZUZklGxNpsooKVAWYlg6HPa5pwe6iut67vI
 FbYra00ygOSBMOHtLkc2qKW6/mmBTdYp87Z8TgrS99laVwssYYso0QYGsmLCEn2frbBThcRO
 4B8bmJj5GyxKkNPGczzNBX4q3y26iMOSF2kbVImbuv6FZTPgMupyuu854PcYxlShDq6fLh+M
 Ai6oR/eu8QYnIduMKk8xxnGrndUf+ld2GdkKU6Okxrm6cq98oJv/z5Mt/498sJLTLn3cbk/Q
 bFEAzsqNHw46tfsuRffUwWE+2ESUn8RkhpGAgjF6A/1U5LsuSbkteRzxTeXM9TuQb87RTqt4
 aFrSAT1iCgcLD427HvXis1rg61Fph+qugFyzJTVYIGRM/p+Y7/dcNYHTmdPQspdSypMCZ6nY
 oARE+QOI/pXr4jlp1sPsxS+AxWsBPjywTNMn3P6wLE23/gkHQzAwQcuHc8BsG7Modv2OqkdX
 u66wrTWwzXNb/1Z2yvy5ofTfxA9uPGBR658fdbPxUQtEQ7Ok1WeqZbiPzOQzukDtHKU7/BjV
 eKykG4stg5/ojyhxsc2i4nJgI0VwU3D+Ct+2ok1P964SFNgYdK+H5VQsy+aN5F3QsMkTGFlo
 yg7xaMdtpKhYScF1o0qyhjCYPOIb4aG+AjsVPqNIThmnnJlfqqyihSw/EWjyODxWcu53EtXo
 yZbj9XBqHAA2hPc5MWFSvZw/0Ws1CqB2Q3d5OxKLk85m6rfJpM9wrA9i4Yfv0vMECLwhU74g
 qiWdkA+9eip7eTqerrmpp6AN490lwHxKb4ildC4AeQ9NAUFQmuV+fyk2bH94EH1Xq9GguMon
 qTbqpzWOMYWqrSkDwNLyoou7xmyAy2o3dgFh3UKKE9JdAiDgoXpPVzFPe71DfOig1S3jDdk2
 erGMKDgApTMMHfOiKvtcLBg4EBG0gUz18pQ55dMB7EBPv3zXkjxucTdDh8+Lgy03/zrCdtj2
 YwFQ26AH7GWPLvTsV+O+O0vP/GBaJEItDrjMfQp+eDigH0jlVMAf6Slx4YbZG6gEvRjOUqZY
 H7sgtkbEWcNuwozVOvkh0eYUT5QenayRLgw6D4/CIKoF4fDR4atgLOa0Sa1AJJZfXpKBU2SH
 nvwcYWLQO8DaDiOLc95jjwESb+hRpc82R22rg/116JnLvbI+i0frZ/syN916PHPmhEz7jF0F
 MSc02SVT25uhG8IRjk23Lp+oUNn0FuD37J40LRkEolh7vhKGj0nLp/ah7hoAtvxHBjcZdaPY
 Fy8RdyqCjY0CNk2xolKK016EN6jphHFxSujRbEPxJKRA5lh16vG3GXqb+t5xWzH0qZp23wvW
 MhSLiuLgqBl9g7cL5HEmQOVmvD5JuwnwCfR+TLbniK1t0ZCXVs1CP2dNZh+Tk7frNCio1jHU
 6frErM/dA1I1c+FLKJOLNzvl1RPAvn5a5zFe2zkvWC2CF6Tw6+UKpLwcjA41T/eFVNCvgQd5
 3eAOiAhCy3nr2+NRCd2GwfXalj3ufJ7tGv9S0Y1yw+QaEg08rOv+QMOw9GYRekS2L0spyor7
 Tl5Tx6mx9yDLd2GqkJ6eblEJ9Mw5FASzWXCqwl0JYCtNYhngUMCNRt6tQXi2n2bE61mls4n5
 DMvxQt2cueD1U9ZMiifxdb2M6HWLW/7+FaubbTX0xfQyoTe/KBH8/k+p1j52WPhXkM/73Vq1
 cVU2HqA993LCgQVS5f4Tkcw8VBzubjbZiA3446c22drNOG4tTrL2tRhA+VAqF7oWt5FM76fU
 iL2HdcbAceGN+Eg3VSkL1oFMO1U6K8oLpa+bfLVkKWvPetmgHenlTEdudo7iBjTsXMjDLeSj
 PNni7mC0wCKVinxlgKku8HzwsVfYC0KW3G40W7iDZJQYat7ecAKD32vKou53IYb5dalVnhG+
 VqkH15D1tWufE/YSlXn3hBLk2kTr2amnySQ0DF+1T0k5Pn6vmSG06H5eRwLN3QeDkxrl1TxO
 s6Zi94AXU6nRxcknl2p6AyposoT7LQ6JG7VT0BSeiHwJGw3Saq8uI2JZMtX4Y8puyFaOAilS
 WiTUaW14x4T0ie4WnBb2Ch+bDay/JPwgx19jmuZand1tnvQP89ql1/T49nVRPgZ2TRjJmEwr
 DDNBUWnefSt88+VkZjrre20EW6sHpFeaijky4qcuTDzvzQwR0flwLbqxZu+S0Azymfj2sNvV
 DnUoRqZAMGjzKm8Pe99PwFpCFL698tmC9R7m4o0iosX3CtSjZGU8Hwb1GbrZI8Cg+SkNiVLH
 GFNmoSGhWqtkFduJX+I2Y/jA3CUw886IsK/fntTwSUlqcZDFKaT6rVA2ypzuFux6wzLMp0f1
 n8Qz+Uj7HkCjqQHog0om2+4C6oRAFIeECjijRWO4Pihoa8RaGvlIt3SnAJu2MusCr2PuFQWf
 X/jeYo5WwJ04N9+Nl3kz3D5rI3pMoq1D5pbpliflBHOiPJQIZQ6m68RhCZpDmn6uGUs1+8xi
 RE9lYH/poWMLH9hub6oGhMNfCOgfNsdo3u+6MQW1tbTxY2kGY9tXykGTIe9B+z9Cyoc7LzuZ
 QOJDSF6tXqRX7bSVQbN7UB7szffHZexKHiNKD8GwN8kSBT4RgQXiVIRWygm25Q+CwahyYr+f
 U0/6j1Z7wz9rQZQj+lzPQT7USGGrQGkM3E/T536TlIe51NH4FrJdMeF5eVpB2cB95ut9UqGL
 WnTcQ1MCSthtlWsIVflM/Hu4NDB97PdHe+iN77VZq3Ir+VCVvCOzJbp0418/j/KON/ddn9lR
 +Y23EZORxUbU4zQhikPRioLlinMc9/TpRGy/Tdyp9y+9/KjURzm5I+GAb9fedt1/BX+jaCGP
 u+WzCF3TFQQnosL3mPNwaMD0UQ6jiZza3+yHL5GuSOMBKPcl6lLDgIKPiN+MMwbisB0lgJJO
 MPdlpb0zusi16RzUQ0aEwW+3JjzNqloaymnOVjKBViGLuGDLDzPmITsZL+kDKZXlKNSvgGxv
 jCSFwniOC6Cnn/nTUPKU6kEgSeFMRhZoIz4fAxqDD2padv8aQCgdvJzgyc3x7IcmX7Ac2IRe
 2sZEQsFvviL4CVUj+8qUXRG9WZgJPKYljyx6u7FNtAJvPEtDik+xIc4qDwqjrBS6i9DXvl8n
 iDf+8Vvr1+Rme6K0jN7URBKp16jZaqOulh+f7rU/N9MVCSclProxXqdAVIGqok9YjUAk79dw
 J7DmfCqQAo=
IronPort-Data: A9a23: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
 bAJeF15
IronPort-HdrOrdr: A9a23:oshdZ6yr/Isnkx9DC+W+KrPw8r1zdoMgy1knxilNoG9uA6mlfq
 eV7Y0mPH7P+VAssRQb8uxoV5PufZqxz+8Q3WBVB8bEYOCEggWVxeNZgbcKqgeIc0DDH6xmpM
 VdmsNFaOEYY2IK7vrS3Cn9Nco8y9+a962Sif7Z1GoFd3ARV0gt1WZE4h3wKDwPeOCqP+tDKH
 IWi/Asmwad
X-Talos-CUID: 9a23:5sBEn21EsS9YewCqB36CLLxfQ5sJbluFwEnrD16KCn1Hb6DNUnafwfYx
X-Talos-MUID: 9a23:dl3+yQiT/CP3aGtw0t2F5cMpGps5uuepVU0xr4gFqsipZQ1rHgygk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,185,1728943200"; 
   d="scan'208";a="102649557"
X-MGA-submission: =?us-ascii?q?MDHfVo8hil29+y3Nr497/0qet/TpmN8X/wyVlN?=
 =?us-ascii?q?I0DcULHV9TB4wxB5b/hP1IIIV6vB4KyI9OdaX9CC2b4E+2db2UAJb4PZ?=
 =?us-ascii?q?ro2q0pVfA1GQfqGWZCEMhINWLYqVjPGZrhlW0JV9HQzgluQKWXr6nBLn?=
 =?us-ascii?q?wpPZP3yhp88kPlEuUWzHznJA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 11:15:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732616123; x=1733220923; i=markus.elfring@web.de;
	bh=p6OdvjNK5miQueD2ZYL1KHVIq+WFp6//zIYw1L/NCA8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FbQ3W8t1CgvEdB526oWF310/esSH3jVfWkr64VQ1e6qOYjPY6s0cooDqJIZRcfPb
	 bCk+pycsE/R/euKU6m1G+OSHP7gS44e/jgm9RToUNMCYEF5rkbwLW0vEBU3kYJRgH
	 ujUBIzkac32M37GbPsq/K7d+TA8TMw/65ro61TFjSh/ojRffl6ot8pYiOhrfSqJkt
	 7D2E4BCFjPzE2Sn2rChb8/oZcUOqNEexh3MiThfPoKLT68VxbXuCvzHqIGnUYefpZ
	 QOfrpFEfiIeNBdB5xgHaD2sUlShR9FGPoHRm9Adi5WNQTudlncY+GVUudD0xc+KTN
	 SWHDXlQMdgi61RVfJw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MHEXi-1tT60B2xQ8-00DkJC; Tue, 26
 Nov 2024 11:15:23 +0100
Message-ID: <c561f61d-cd46-4eea-b36d-231b70d4e32d@web.de>
Date: Tue, 26 Nov 2024 11:15:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zack Rusin <zack.rusin@broadcom.com>, cocci@inria.fr
References: <CABQX2QM+cBpVhcBYRae+W4n5a6bVJ=sC+zu9GGj0veiqvU2_4w@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CABQX2QM+cBpVhcBYRae+W4n5a6bVJ=sC+zu9GGj0veiqvU2_4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dbUViQDxvX7L05Y/zPYrzmWkpUkI3D12CilXswZ9UYtGobCPuzt
 XdIaEyj2xJSp78KHbLszmt/JPXp+CgPP3WZr5WjCmYGGzyL3B4kamq4AWEz75nxtc9pIvXl
 9j/xF+24QhVV0+ZftYZslzTcz55gJPCg8CJAcKyA3Wzr6B68vGYjPBJWDSmqdpEm6x/qarp
 kIUW+bi8uVIGOHEcIwW9Q==
UI-OutboundReport: notjunk:1;M01:P0:tOBHeaQ+0Ro=;7QzRiilKISyunPlUrp9cczSiAIa
 4jCdTH+EAJuPW/JNIhbjVgL7aH4LOL5AV1ERtmuvVHEdPWORYFESYlqB//0yIsL5DoJT4n7Zp
 at142wmPn7c5L3bBLaD0RhDlOCRc3yNNUAsPqIiyi7SZziUw+PD6QaLVOsQmILk+5AdWJUtR0
 eggtlaf1QXvNdm/e0WokFAjqyxiXhn/nDZxiSgqiyEdtvZYQ7+x6W+vdFgzIh0Uv8xKMxtEDl
 UImscKams8OZE5OnNuRUeZV3BjYdwIJftGm/oUH3dLcBNkPj7Q8kbsOBoPoJVks1NERJ94qxf
 PZU67UCi8feH71AsuGGG5F7+CHD6VSNP7qfJq95CUgXPpEAwIcUoXuFb1XGYgDssECWvkW3h7
 ObKMOkIA6dCi4bd9MekFme5IKuJO/mF1rqww391C/efUnpCggQ3h1BZ0LxO5oR5GHEcead4G5
 gRRSLJxxnyj9wG7nYc45Xarj/pnUTSQ61tZCLlchsLfWGbIuN7XciqBQNgjylnC58j0unZU7u
 UFEmbfsx1qMTp47jbMga5XooByHFdFfdvfvuqJoSP4AOYjR/GxEoWT12kPrJBpZWBcWRLJG6g
 8e7iN/uJX7qlOry7wxTHIy8YUQPNi9nWpXEeRdz+ga1g4+qq6cxprzUswulspwVMetDMzQrbZ
 yYJgWHOxdLzW7WK11FSnwsuT8DDD35bDnrl0RlBDbv5bUECRRnQXtB3JMRQlm/MSQcugvIxF2
 nJ1yfRcHK6oOjzlKgUjVA0ir9E/thdpoRTjCbFRkA7aiSxiY3tVTBnx0UYKSIgMTirRcAQfnW
 fAOV1vLtmae5m4nzMpoNbgnIrVYIQpirBYAZMxwElzlkrVxCOe8BWYgddoNan2nFu0S3+pbpp
 ue+Dgr8u7xlGCXQRNPrtdDd1MyqrjQ9lGIbVXvFD+tg20oe0tH9TzhOnZ
Subject: Re: [cocci] Replacing type names
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2129
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/c561f61d-cd46-4eea-b36d-231b70d4e32d%40web.de>

> I'm trying to write a  script to snake case all type/function names
> but I'm having a hard time matching some types. I think I'm missing
> something silly.

Our application knowledge can be improved accordingly.


> My input script is:
> https://gist.github.com/zackr/198db11e5e5243adbdc59b9844d8eb6b

Would you like to reconsider the use of position variables in such
an SmPL script?


=E2=80=A6
> -typedef struct SomeDevice {
> -    uint32_t sampleVariableUnsigned;
> -    int32_t sampleVariableSigned;
> -    float floatVariable1;
> -} SomeDevice;
=E2=80=A6
> I'm guessing t@p somehow matches three times on the typedef structs...

I am unsure how much it should matter here that your structure example
contains three members.


=E2=80=A6
> Plus is there any way to transform arbitrary function names?

Probably, yes.


> I'd like to endup with:
> https://gist.github.com/zackr/c37683157f10b2728dfd3576c88e64f7
> in a generic way that basically can transform any arbitrary type,
> function and identifier name.
Your data processing goals seem to be very ambitious.

Regards,
Markus
