Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE91C4332F
	for <cocci@archiver.kernel.org>; Sun,  4 Dec 2022 09:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=YfZ2y9Qb4FI/eO63Xs9tIz8UdNQXAowepe8A5JIEW0w=;
  b=rX7/346ZPkhg3nns88s9dQzfwshmUhsl6w5d/zm0wgeYTw8PIKbl23wU
   dDQY6x2GNDXZn3rq30cZATxWYI53evzjiLZNrnXwkl32kMMOcZ3llo9RW
   +X7dGixyWRL1I3H0l/UQozAYOo9c8DeuTHPKk9YTrVsl9cAqaBF1ncGeP
   w=;
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
X-IronPort-AV: E=Sophos;i="5.96,217,1665439200"; 
   d="scan'208";a="81581410"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Dec 2022 10:49:12 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6CA4AE019F; Sun,  4 Dec 2022 10:49:12 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3BE8CE013A
	for <cocci@sympa.inria.fr>; Sun,  4 Dec 2022 10:49:07 +0100 (CET)
IronPort-SDR: 638c6d12_yd/p6B3ZnSBTIPU50aPAdy469KIdYwrFuu4AL1xamTKBREL
 fqJqby4+0Pk4nMRZ7FtHmOs9T0hNM2rK80u0pRg==
X-IPAS-Result: =?us-ascii?q?A0G5BACZbIxjhwMP49RaHgEBCxIMQIFEC4ItgQVWLgQLR?=
 =?us-ascii?q?YRPjneBdzGEK45SijiBQD4PAQMBDT0EAQIEAQEDAwGCC4JzAoUPAh0HAQQyB?=
 =?us-ascii?q?w4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEaCRcHDhAFI?=
 =?us-ascii?q?oVoDYI1KQERZFM1AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQECDToYOz0BAgIBIx0BAREmAQQLCxoCJgICVwYNCAEBgnoBgm0BA?=
 =?us-ascii?q?w4jBwyuOIEygQGCCAEBBoFAARVBmXAfLCJTgV4DBoEULJEYJxCBVUSBPAyCR?=
 =?us-ascii?q?zA+gmIBAQKBXoNXgmeMUoMOhw0OYiUEDgMZKx1AAgELOzIKQzUJAhFMEBscG?=
 =?us-ascii?q?weBDCooFQMEBAMCBhMDIgINKDEUBCkTDSsnbwkCAyJhBQMDBCgsAwkhHwcVE?=
 =?us-ascii?q?SQ8B1Y3AQQDAg8gOAYDCQMCIlRzAi4RFQUDCxUlCAVJBAg5BQZTEgIKEQMSD?=
 =?us-ascii?q?wYmRQ5IPjkWBidBATAODhMDXYFpBDNmgQsKLy6YVIIZaFnFDTQHgh+BTYFQD?=
 =?us-ascii?q?Il1lHQGEy6WcA4GkhaXP41EmjaBaQ4lgVwzGiSDNk8DGQ+OIBmDWTOBC4khQ?=
 =?us-ascii?q?DQCCTACBwEKAQEDCYVHAQGEVgEB?=
IronPort-PHdr: A9a23:7rO47hMEWb/gWbEqyCsl6nbgBxdPi9zP1u491JMrhvp0f7i5+Ny6Z
 QqDv6gr1QWCBdqTq6odzbaM7+a4AS1IyK3CmU5BWaQEbwUCh8QSkl5oK+++Imq/EsTXaTcnF
 t9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFRrlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+M
 hW7oR/MusUIjoduNqQ8wQbNrndUZuha32xlKUyckhrm+su84Jtv+DlMtvw88MJNTar1c6MkQ
 LJCET8oKXo15MrltRnCSQuA+H4RWXgInxRLHgbI8gj0Uo/+vSXmuOV93jKaPdDtQrAvRTui9
 aZrRwT2hyoBKjU07XvYis10jKJcvRKhuxlyyJPabY2JKPZzeL7WcMgETmRdQMleSy1BApu9b
 4QRCeoBIf1YpJT5q1cXsBeyGRWgCObpxzRVhHH5wLc63vwiHw/I0wMvEc8AvmrarNjrNKkdU
 /y6wqbTwDXfdvNbwyvx5JTGfx0jp/yHQLJ+cdDWyUkqDw7LiU+fqZbmPzOIzeQGrmeV7+5uV
 eK1im4nrQ5xqSWoy8krkIbJnIEVyk3f9Sljz4g1IdO4SFR6Yd6iH5tdrC+bOJVtTc84Xm5np
 j83x7sbspG0YCYE0o4oxwLDa/OZaYiI5AruWuiMLDl3mH9od72xihWx/EWjy+DyWde53VZWo
 idEk9TBtG0B2h3O58aHV/Zw8Ems1ziN2g3R9O1JPFw5mbTGJpMn37U+mJ0TsUHZES/3nkX7l
 K6WdkM++uip8evreLvmpoWEO497iwH+LqQumtGkDugiLgcOWG2b9OKh37Pg5U30WKtGguAon
 qXDrpzWO8YWqrSkDwJVyIou5Q6zAjOp3dgCk3QLMUhJdRGJgoTzOFzDLvb1BuqljVu2ijdk3
 fXGM6XhAprTKnjDl6/sfbN6605B1Ao/195e6IxPBb0bPf38RFf9tN3eDhAnLwy52/jrBMhj2
 o8ER26DHK2UPLnPvVKI/O4iLfGAZIoPtzb8L/gl6eTujXg8mVIFeqemx4EXaHOlHvR9OUmXb
 n7sgtkbEWcLuAo+Q/fniVOcXjFIfXq9Qrwz6ik9CI29FYjDXJyigKSd3CenGZ1bfn1KBkiWE
 Xj0b4WER+sMaCWKL8B9lTwLSaSuS4462BG1tA76zqJnIfDO9i0Zs5Ljztl16PfJmRE87zwnR
 /iahiuhQnt5nSstAXcU26ZyugY1nluOy6V7q/9eEsdU6bVCVUEnNsiP4fZ9DoXXUxjCY8zBZ
 VKoWNSgDnlla9srwMIVJWt5Fc+jiB/rwCegRbMYwe/YTKco+77RiiCib/12zGzLgex41wFOq
 qpnMGSngvU67A3PH8vSlF3fka+2dKMa1SqL9WGZzGPIslsLGBVoX/DjWnYSLlDTscy//lnLG
 pqnE7c6KU1szcCYK61FQsLkhxNKSaSrI8zQNlq4gHz4HhOU3vWJZYvudX8a2XD4AVIHjhtV0
 HKILwk4CQ++rmiYADE9XUn3bRbK9u9z4Gi+UldyzwyOaBh50KGp/xcOmfGGY/YUw65Cpyor7
 Tl5dLqk9/TRDdfI5w9ofaEHJMg4/E8CzmXB8Qp0Ip2nKalmwF8YaQV++U30hV1xDc1bnM4mo
 WlPrkI6IL+E0F5HazKT3IzhcrzRJG7o+RmzaqnQkljA2deS860L5bw2sVLm9A2uE0Mj9T1g3
 bw3mzO574/JERFUfJb/SEcx+DBlqrucbiR8r4LY2HtwMLWl5yfY0oFhD+8kxxC8OtZHZfndT
 kmoSZJcXpXoc79P+RDhdB8PMeFM+bRhOsqnc6DDw6u3JKN7myrgi21b4Yd720bK9ixmS+eO0
 YxWppPQlgaBSTr4i0+s987tnoURLxQbBGmi0m7JAIBLZ6t9VZkGAyGiLofko7c2z46oQHNe+
 FO5Uhkj0dWqZAHUQljzxwxW2mwIrHbhlSbynFkW23k566GY2iLJ2eHrchEKb3VKSGdVhlDpO
 YGojtoeUSBEdiARnQC+rQb/zqlf/+FkKnXLBFxPZ27wJn1jVa25svyDZdRO4dUmq3cfXOO5a
 FGcArnzxnlSmwbqBWhD33YWcz+wu5P2twN3giSRIT5/oWHYdsd52RrErIaFH7gLhGVAHXQ+0
 nHeHRCkMsOs/MmImpum0Kj2TG+nWpBJMGHqwY6GqCqn9DhvCBy7keq0n46vGgw73CnnkthyA
 H+R9lCmONatjvn8arECHAEgHlL35stkF5srl4IxgMpVwn0GntCO+mJBl27vMNJd0Ka4bXwXR
 DdNzcSGhWqtkEBlMH+NwJr0E3uHxc40LfyzeGALwWQQ685QCaGbxKNJl215rxDryGCZKeg4h
 TobxfY0vTQ/ivsKpRFr4yGTGLEUEmFHMCaqmxnCvLXc5O1HIW2od7a3zk93m9usWaqDrg9rU
 3H8Yp4+HCV045Y3IBfW3Xb08I2hZMjIYIdZqEiPixmZxbswStp5hr8QiCFgI264oXA117txk
 0l1xZ/j9Imfdzc3pfj/WEQHcGSvOYVKoGGq1/s7/I7e3pjzTM84QHNRBsSuFK/uSHVI6LzmL
 1rcSmRm7C3BRvyGQknHrx0553PXT8Lxbi7ReyNflIQ4AkPBdAsF0WV2FH07hsJrRlrsnZK8N
 h4kt3ZJoQSm4hpUlrAybka5DT2Z/l/3LG9zEsfXLQIKvFsbuAGKa4rHv7g1QX0fpMPEzkTFK
 3THNVQSSzhXBwreXQGlZ+L2rdjYr7rIXKzncaaIO+7W77YEH7KBwZblumd/1xCLMMjHfnxrD
 vlgn1FGQWg8AMPB3TMGVy0QkSvJKc+dvha1vCNt/Ii597zwVQTj6JHqafMaOMhz+x2wnaaIN
 vKBzCd/JzFC05oQxHjOgLEB1V8WgitqenGjC7MF/SLKSavRnOdQAXt5I2trM9BU6qsnwgRXE
 cvcl8+zybNyyPI4Sh9EWVHnhsC1dJkKLmW6ZzalTA6AMLWLIyGOwtmiO/rmD+cK06MN6lvr6
 lP5Wwf5Mz+OlifkTUWqOOBI12SAOQBG/Zq6alBrAHTiS9Tvblu6NsV2hHs42+5R5DuCOGgCP
 Dx7a04IoKeX6HYSp/xlGHFaqFdhI/OFnSmx8OTSbJob+6gOYGw8h6dB7XI2xqEApjlDX+Bwk
 TDOo8RGpla7jq+QxzAhXBcE+VMpzMqb+E5lP6ve7JxJX33JqQkM4WunABMPv9J5C9frtsi4L
 /DQmai1JDoQq7o8HOMZANXIbt2KOjwtPEixcNY7JBQIR3inODOG73E=
IronPort-Data: A9a23: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
 D3VxpE80tVdDH2kqSb/K8FXWdta+84=
IronPort-HdrOrdr: A9a23:uDQI3aiuvO34p/LI5b4QCUq76HBQXg4ji2hC6mlwRA09TyVXrb
 HLoB1p726WtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW31dAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykesS+Q2mmF+rgbsbu62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,217,1665439200"; 
   d="scan'208";a="41660707"
X-MGA-submission: =?us-ascii?q?MDEcwCExdc1M6oiqVA+U6SbCeCnFqJtIoLK2FL?=
 =?us-ascii?q?ggQKXOW1kCNPwN2+y6IiYp7iowrUzU2E9KGlQsfHfH2XNzl+rVzP/8xV?=
 =?us-ascii?q?b91P0JyQoHxOrcIDeMmhojY9EYzeNPx8S9ghrxsCvaoXdPpm40c3+OQa?=
 =?us-ascii?q?Xojx25J7W33ViGC96VQnEoIQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2022 10:49:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1670147345; bh=YfZ2y9Qb4FI/eO63Xs9tIz8UdNQXAowepe8A5JIEW0w=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=QiuNN/01NX/ywTIvnqnUXEGwp6AGXKLftySbVXwlvRrBjjuEVoZxozJxizsOXrDjA
	 Lv+qOHjC8VdHMPWzvBzyU6W2O2BCzBMQG16450Q8Z0zZgpaHAKzzRfA9e8gCKRSNMJ
	 3ED7eR5whZJU6JrN9BWdRNQD1D6i5o3LZFof7TqnrThRzJbaIUNRgoV0MAqoFOzKet
	 Kh7O7msi3mS62G+iQFbhMruqdWD2f7kUHNzpdxtNHddZzKwyi4+I3p86YFhEMSDuJR
	 mssEvF/JYT4Zc6Kg4tFeY185G/htPF0O6beR/9eVkgfa9iOp2L6sblV48uyTXpSB0g
	 Dy4DLME8j3+RA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MECCP-1p9ha81y0z-00AEjy; Sun, 04
 Dec 2022 10:49:05 +0100
Message-ID: <636c36f2-652a-6912-ceb2-7e2a3330ee1f@web.de>
Date: Sun, 4 Dec 2022 10:48:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-GB
To: "Derek M. Jones" <derek@knosof.co.uk>
References: <a9cad00c-ede3-338d-da7d-801dab7d51c2@knosof.co.uk>
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <a9cad00c-ede3-338d-da7d-801dab7d51c2@knosof.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jTYvOd+kJ7SE46XHCOQ4DCJtxo1dHV22/Sb+I8Ro5o28jBhy9Li
 2FaManKMqi0ofT1jjIm9D1Dz/37s0MVmlQpjy2TNPmU6qYIr7AgGAGA4yrldxGshbqWvRtL
 bhIVTzySp/u8BzVT7dDJat1kMdpXVtOL01o+Cc7vsXDbMpllkyVbg7X1/hfS+V5AUTWc+lB
 GwZVzVMeFC4gpkAhzJZ1w==
UI-OutboundReport: notjunk:1;M01:P0:TyexlnxJvG0=;Vu651t3h2BzWQHmKsx/qeqxxy3A
 VzztjbjSmIXfGY6JeP+UB8xUqeuxQWmr+eX4q5YsfnJ/QeqhowlVdFNi5serH59x286Vf5FPx
 VGjhw/VMw0mIEG8azQLjFpY/+fUWyygQ2IjRcOjXkEOfo1R3ojp0o+QbIqWGrW6u7a9GzKVAz
 yfTqTOk5mYXuWafrnGaEhvaa+Xm7H2GTlDsKAacuktm+NoinYOK8g8frVljGPsR4VpIAK/yv8
 1617i6+QmuvjWq+Oo1+8GvxeXvpNSUlDxjdmEgPjy5LHXKV14Uz8KVLK5uBG0/tDwI8EdWFnd
 b+2Ky/ewwUyJ6UEbZPjnDMnFWHWGaj6wt3ayVv9FkcOD/65tkenlWEOP6UD7sts3AfroIRGGH
 pI1TD+nf5yES8jw2N0NdPMUvLCO8EgshKNrseMskveOJMc5Ylf1k9nZ3RC0TOIw2D52Xn24dL
 vRMSqL2yOEX/2Rt6g0tKBRL6XA40ZrS4lgDBQIYC/sjY+e78m0iQtIFRDM/DTKb52jJanDD6Z
 Tpfx6jZ1kDl/Svj2f7ap+Rd6PEPpp9kEenjdMeuPCbmM5MtcrlJkTt36nffKAAOoOn05/dgiG
 esdDVZ1+kewQECk6qnuRWWd36cZUcxTpBx2H4Q51wQ4SUX5tMV79HjBsJy14KMOpiiDY6hLBz
 9Nl3yFxlc0d2aQYAyOiAULV7MG3p+ZM51GOvULk8s27y+lf+WcLfFIDFxnZjmbUbcqywlqzu1
 YMSzck7h4Os9XjOFXD1Z5wtYC3PUZccda++Ue55QygCVhVKdc+9tqRGSSA2iCELjB0i9u465d
 +YlqU2phmUW6Gj0IxBC36swXGPFOZGa4XxnoyYwYj6xZl+nrlPI8m2gknJ535RFqoIWwYumQ9
 Efx/xmxQXlBzS6XUQKr97968fl5BwY/XTXS05tahiT05KjVW6F2osPzl6e8GOskMmVMrLQhhr
 L616PQ==
Subject: Re: [cocci] Searching for modifications of volatile variables
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 761
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/636c36f2-652a-6912-ceb2-7e2a3330ee1f%40web.de>


> Actually the line
> V_1 b E_1;@p_1
> does not match anything.=C2=A0 Is this because the assignment
> operators are not considered to be binary operators

Why would prefer the specification =E2=80=9Cbinary=E2=80=9D over =E2=80=9C=
assignment=E2=80=9D for your SmPL test case?


> (they are)?

Would you like to achieve any further adjustments for the Coccinelle softw=
are?


> identifier V_1;

Would you occasionally like to add the type qualifier =E2=80=9Cvolatile=E2=
=80=9D to such
a metavariable declaration?

See also:
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/635b0308c0fd40e65518d=
d4f422cea2bb985bbf2/docs/manual/cocci_syntax.tex#L1384
https://github.com/coccinelle/coccinelle/blob/92306d3f2d625ba66bc7f28eaacd=
2d8bc33e0707/docs/manual/cocci_syntax.tex#L1384


> (
> V_1 b E_1;@p_1
> |
> V_1 |=3D=C2=A0 E_1;@p_1
> )

Will the application of such SmPL disjunctions evolve any further?

Regards,
Markus
