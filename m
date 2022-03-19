Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356A7C433F5
	for <cocci@archiver.kernel.org>; Sat, 19 Mar 2022 11:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=MF4obd0Fk5uKDpBbbwTCI5VEcSzoWwpqYKOWCjRJgEw=;
  b=TfjsGlDt0SIwa81gmIpIXGEdNiAcXLgLtoOJiVcMw3h5qdb85vElwfcs
   hLCjH3UXL8cwr7E0VNJLhlebRiuIdL+GiBiKpU+UPb/cdni2RVsuB4V0B
   5sDbG8CwMse4xTzTd098MtnhFpbwVzXQ/ypUbEeyvujTel3HsEf7iMShf
   I=;
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
   d="scan'208";a="26995942"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Mar 2022 12:52:44 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 631D8E020F; Sat, 19 Mar 2022 12:52:44 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AAD12E0069
	for <cocci@sympa.inria.fr>; Sat, 19 Mar 2022 12:52:43 +0100 (CET)
IronPort-SDR: szRtYp1lVA7D7omUlvzuhhF2zvNPtAnwVW5SK03PycjcKXU4tWkY2adeDjJYITV9rmxrQSdM0O
 xdjGzR9i4K3k1QvD4frCkG0HzdmzRAeBQl9hU/Ube3hGJgA/mx6yYiE6rIqDy116ggLJgVd9AV
 h4oamc71o7/4Dvp7LnAkZzZQK54CyD1WkftYjVy/mnjeXQFdTfU7hZHFMYAM/dYH4aD35FYOy3
 zCSp4r4BDDxV3cYtiDiIsRleQSpfmhJXsSqPNnrRA69Yyga3IIOYaqLuvGbC96Ti190/Yua+mJ
 bXo7tB4YrnqieJDIWtkfdyDz
X-IPAS-Result: =?us-ascii?q?A0AoBQCwwzVihw4P49RaHgEBCxIMQIFcgiaBVSsEC0SEF?=
 =?us-ascii?q?j6cP4cYiiiBewsBAwENPgECBAEBhQMCAgKENAIdBwEENgQNAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQwNCQUICgcOEAU2Bl4GZASBSwSBd?=
 =?us-ascii?q?As0DYI1KQGDZAMDDBcdAQERJgEPCQIaAiYCAlcGDQgBAYMAgmUBAzKRaZwMg?=
 =?us-ascii?q?TGBAYIIAQEGhEgfLCJSgVsJgRAtjU56JxCBVUSBPAyCRzA+hEWDGoJllyByl?=
 =?us-ascii?q?imOCp93NAeCEoE6gUEMnhEGFC6WPQ4GkW2WW6cCgXsEgXczGiSDOE4BAgECD?=
 =?us-ascii?q?QECAgMBAgECCQEBAo4dDA0JhAOKLEA0OAIGAQoBAQMJhUcBAYoFAQE?=
IronPort-PHdr: A9a23:WV97tBTpE836aLQoBIMTS5QREdpsorWVAWYlg6HPa5pwe6iut67vI
 FbYra00ygOTB8OCsKIP0LOempujcFRI2YyGvnEGfc4EfD4+ouJSoTYdBtWYA1bwNv/gYn9yN
 s1DUFh44yPzahANS47xaFLIv3K98yMZFAnhOgppPOT1HZPZg9iq2+yo9JDffRtEiCCgbb58L
 xi6ogvcutQLioZ+N6g9zQfErGFVcOpM32NoIlyTnxf45siu+ZNo7jpdtfE8+cNeSKv2Z6s3Q
 6BWAzQgKGA1+dbktQLfQguV53sTSXsZnxxVCAXY9h76X5Pxsizntuph3SSRIMP7QawoVTmk8
 qxmUwHjhjsZODEl8WHXks1wg7xdoBK9vBx03orYbJiIOPZiYq/ReNUXTndDUMlMTSxMGoCyY
 YUAAOUPIOhWsYf9qVsMohSiCgehH//vyiZSi3PqwaE33eYsHAfb1wIgBdIOt3HUoc3yOqgIS
 +C1z7TIzS7eZP1Z3Tf95pLIchEnofGDQLl9ds3fxlM1FwPGk1WQspbpMTyR1uQDqWib7uxgV
 e20hm8ptQ5+uSKjydoyhYTQgI8e11/L+zljzokvOd24VFB0YcSiEJZIuCyXKoR7T8AgTm11p
 is0xaMLtJ6lcSUE1pgqyR/SZ+CEfoWG/x7vSPicLzh4iX54fL+yhQq//0i9xuD8WMS53lBHp
 TdGnNnUrn0ByQHf5tadRvdj4Eus2yyD2x3T5+1ePEw5mrLXJpwiz7IqmZcesl7PEjL1lUnol
 qOaa0cp9vau5u/6eLvpvIWcOJVxigzmMqQhhMi/AeMgPwgLWGib5Pi82Kft/ELnW7pGlOA5n
 bfBvJDbI8QUuLK5DhdL3oo+9RqzFSmq3MoakHUdMV5IeAiLg5XmNl3WJfD3F/a/g1CikDdxw
 PDGO6XsDJLXIXjZk7fhYK1951RTxgo3w9Bf/ZNUCrcOIP/oVE7+qsfXAgUkPAOq2+rnDs5y2
 ZsEWW2TGq+ZLL/SsViQ6+4xO+WMfpMauC7hK/g54P7jlXs5lkUTfKaz2ZsXbGu1H/VnI0Wce
 nXsmM0OHX0Lvgo4VuzqiUeNXSRdZ3aoR648/C00CJq6DYffQYCgmKCO3CCnEZJKZ2BLEUuME
 Hftd4WcQfgAciOSIsl7kjwFT7etUYEh1Qv9/DP9nph6KuvdsgkRqpvn0JAh5fDXlBh08TVrB
 sCZ+2CLVWB92G0SEWwYxqd69Gl00FSeyuBVh/JCFNpcr6dsWx05KIWa4uh0EdH0VSrec93PR
 FvwEYbuOi04Ut9km4xGWE16Adj3y0mbh0JCYpcQnr2PX9kv977EmmP2P4B7wmrH068oix8nR
 NFOPCuonP037BDdUqjOlUjRjKO2beIExieY0W6ZzneV+mxcXhRxV6rtQn0VIEfb/pzi/k2Xd
 7a1Evw8NxdZj8uLK69EcNrs2HBPXvT+I5LzZ2yrmmG/LQmFzPWAYdmiYH0TiQPaDkVMiAUP5
 TCGOAw5Uz+muH7bBSdyGEjHZkTx7a9hpXn9QkJcIxiiSUpn2vL1/xcUgafZUPYPxvcfvz9nr
 TxoHVG71taQCtyapgMncr8OKdU6qExK027UrWkfdtSpMrxii1gCcg92o1Km1hN5DZ9FmNQrq
 3VixRR7KKaR2ldMPz2C2pW4NrrSI2j0tBehDsyeknTXytWL4eEi7PoiqlPslB6kHAwu/jQv0
 tVY1Wed+oSfFBAbAtr6Vkc68QQ/pqmPOHBnodmOijs1bO/t7mynuZphHuYuxxe+cs0KNaqFE
 FS3CMgGH421L/RsnVG1bxUCNeQU9aguPsrgeeHVvczjdOtmgj+iinxKpY5n1UfZvQ91UO3Vx
 NAox/+C3w2IfyjxhhGtv4qk/OIMLSFXBWe5xSX+UcR0b7dxYJ1NJGOgOcyxyf1hipSrV3MSp
 zvBTxsWncSufxSVdVn02wZdgF8WrXKQkiy91zVokjsto8JzxQT2yv/5PFoCM29PHyx5iEv0Z
 JOzl5YcVVSpaA4gkF2k41z7zu5VvvY3I27WSEZONy/4SgMqGo65rLmfeIhi7J0ysCNYePuxa
 xaWR/bxrgAb3CXqA2ZFjGpiLXfw4Mq/xkE80T7VJW07tHfDfMBs2RrTgb6UDeVc2DYLXmgwi
 DXaAES9I8j8+NyVk5nZteXtH2mlV5BVbWzq1dba7XH9vzc1R0Ti2anvybiFWUAg3CT21sdnT
 3DNpRf4Oczw0riidPlgZg9uDUP97MxzHsd/lJExjdcewyt/5N3d8HwZnGP0Kdge17j5aS9HY
 DcRwMPOpiXh1ldiKH2h2I/zEHmQiJgEBZHyciYN1yQx4tofQoKd9r9Zhm1YplSirATeSedwl
 HERxLF9jRxSy/FMsw0rwCKHB7kUFkQNJi3gmSOD6NWmpblWbmKiIvCgkVBzlte7APSesxlRD
 TznL4w6E3Y6vaAdeBrclWf+4Yb+dJzMYMIP41eKxgzYgbEdKYptxKBT32w9Yz275Cd7jbdh3
 Vs0gPTY9MCGMzk/pvvjREQCaXusOoVLvWuwxadGwpTMhtrpRM8+XGxUGsOvF63gESpO566+a
 EDRSntl+y3dQ+aPWlXOjSUu53PXT8L7bTfOeiRflIgzAkHafhIXgRhIDm9jwdhmTEbwnJOnK
 AAjuXgQ/gKq8EITjL0ycUCuCCGB+EDyNFJWANCeNEYEvlsEvhmId5bEv6QqRHkQ/4X9/lzXb
 DXFOkISVjlPABbMQlnnOvPGCcDo1e+eC6L+KvLPZe7LsulCT7KTworp1IJ6/jGKP8HJP394D
 vR91FARFXZ+U9/UnTkCUUl132rEctKbqRGg+yZ2stH38fLlXxjq7JeODL0aOMtm+hS/i6OOf
 +CKgyMxJTFd35IKjXjGrdpXlEYVkD1rfiKxHK4osCnQUOTPl6URAxNaIyJ/Oc1U7r4tiwlAP
 cmI77G9nrV8j/MzFxJETQm7w5vvP5ZVZTjgcgqbVyPpfPycKDbGwt/6e/a5QLxU16BPsgGo/
 C2cCwnlNyiCkD/gU1auN/tNhWeVJk872sn1fxBzBGzkVN+jZAe8NYo9qDQswqAvwF7OO3QdN
 zdUbE5H6LGdp3A94L03Cyla43xpIPPR0T6e9PXdI40KvOFDByNpi6RF7X58x7Yfv0QmDLRl3
 SDVqNBpuVSvlOKCnyFmXBR5oTFOnIuXvE9mNM0xGbFfVHyC8B9ftA146jwPoMZ5TMLiseZcx
 4qX/EoWAChP+ZTY8JlEb/U=
IronPort-Data: A9a23:F/mc7qiJlTPROZ1ZP4X7d8/XX161cBYKZh0ujC45NGQN5FlHY01je
 htvDDyCaP/eN2Xxeo13aoW0/B4GusLQzIRgSFA+qy4zHyNjpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UKidUsxIbVcMpB0J0HqPoMZkxN8w6TSFK1nV4
 4mq+JSOYAXNNwNcawr41YrT8HuDg9yp4Fv0jnRmDRyclAK2e9E9VfrzFInpR5fKatE88t2SG
 44v+IqEElbxpH/BPD8KfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1hUp/0120c95NJ
 NplipPqRTkGZa/2t/1MECRxPnBjBe5FweqSSZS/mZT7I0zudnzx37NxAUtwMYBwFuRfWzgUs
 6ZCd3ZUM1ba24paw5rjIgVoruEqNsr2J8Uyvn96zDfWJekrS9bPTs0m4PcJhG1p2pAXdRrYT
 5YcbjVsRhjuXwIVG2U0AqxvjOqZj2aqJlW0r3rM+PZpujGNpOBr65DpOcXcftiiV8RQlFyR4
 GPA5WXwRB8AXPSUzjGO81q3l+rXlGX6XpgTHfu27JZXbEa7w2sOFFsJWFH9rfTRZlOCt8x3F
 ENO9hQB9qoI21X6DeTUckylmD2Hh0tJMzZPKNES5AaIw6vSxg+WAGkYUzJMAOAbWN8KqS8Ci
 wfVxIm1bdB7mOLFECLHnluBhW7qYUAowXk+iTgsYSZtDzPLhYY1khvFR8t5eEJepoCrRWioq
 9xmhBI+irQViccN2+CD81nDkVqRSnXhSwko+kPIU2jj4g4RiG+Zi26AuQWzARVoddjxory9U
 J4sxZL2AAcmU8jlqcB1aL9RdIxFHt7cWNEmvXZhHoM66xOm8GO5cIZb7VlWfRk1bZtaIWK3P
 h+M5Wu9AaO/2lP6NcebhKruWqwXIVTITouNug38M4YfPMMrHON51HszPhTKt4wSrKTcufhiZ
 cnCKJjE4YcyUOo+hDuwW+oH17I3jikxrV4/trirpylLJYG2PSbPIZ9caAXmRrlgsMus/VuJm
 /4CaZri40gOCIXWP3iMmaZOfABiBSZgX/je9ZcIHtNv1yI9RQnN/deKneh+E2Gk9owJ/tr1E
 oaVARYJlgCg2SWZdW1nqBlLMdvSYHq2llpjVQREALpi8yJLjV+H4PhNep0pU6Mg8eA/n/d4Q
 +NbKdqNCLJDR22fqTgaaJD8qq1kdQiq3F7fYXD6PWJnJ5MwFRbU/tLEfxf08HdcBCSAtfw4/
 ++q2DTdTMdRXA9lFsvXNKmiwgrp73gQke5/RWXSJdxXdBm++YRmMXKjkfI9Zc0BcE2Ryjyf3
 geQIBEZueiU/95rqoaU3/jcot7wQeVkH0dcE23K1pqMNHHXrji53ItNcOeUZjSDBmn6z6WVY
 7kHxf/LNvBazk1BtJBxEuowwK8zu4nvqrtdwlg2FXnHdQ3yWLZnP2XAwsRF8KFAn+cLtQyzU
 0OJ299bJbTQZJK7SgFMflJ9Y7TRz+wQlxnT8e8xfhfw6hh3y7zbA09cCB+B1X5GJ7xvPYJ5m
 uos5JwM5wqkhkZ4O9qKlHkNpWGLM2BGTKgt8J0XWde5hg0uw1BEQJrdFi6vvMDRMYoRaBFyL
 2/GnrfGipRd2lHGLSg5G0/N6uwB154AjxZHkQ0ZLFOTl9uZ3fI60XW9K9jsoti5E/mG7w5yB
 oSvH0hyOLnI4DpiwsRON4xp98etGzXBknEdCXNQ/IEac6VsfnPAJisxNI5hOWgHpnlEcGEzE
 K6wkQ7YvPWDQC019jQ/UwhpppQPiDC3GhLqwKiaIihOI3X2jfcJTENjiarkZiYL2f8MuXA=
IronPort-HdrOrdr: A9a23:oynvha+nBSLK3mRgo0luk+D8I+orL9Y04lQ7vn2ZhyYlF/Bw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObOEYZmIbsS+V2njbLz9t+ri6GLvDv5ak856Bd3ARV0lYhT0JdzpymSBNLjV7OQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,194,1643670000"; 
   d="scan'208";a="9021481"
X-MGA-submission: =?us-ascii?q?MDH6onqkcoqxNAkNzS7R91CUrEDMo3fRrFYaDr?=
 =?us-ascii?q?7wGNYZivcjkkWtcfxaf6sikDae0VvccKYXk3muT8hx4z4yOicBBbBxbW?=
 =?us-ascii?q?XVykI+dYw5nnKq7e+3cFUJoBfb5p7I5hhIo92VNHfCdh2/ArdGrhHCb4?=
 =?us-ascii?q?jQkxDVGT32bF/H4M6X5kaeHA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 12:52:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1647690746;
	bh=piY7JGW5gcXeDsDGE1FJHMU4pBQ5KM3j9caC6cAn+gc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ByyN5m3dtoD8RMYz+LM6pN5SlMcMCUfd1LgR+v1NQMCLApYEuT7eX54a28XcZMS5K
	 jIEzjkKuNEuwQH/ZrsYU1rnsKcZ2y3R8PxLviI6/uz3Bt+UXSAoItaDz9nSWZ1UbHL
	 jpDN54yAxLFEueQ3gEbKTID6PJ6Zg9fwD7ZCJFWI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.182.172]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3m9H-1nVoTp11X9-000dOd; Sat, 19
 Mar 2022 12:52:26 +0100
Message-ID: <869caaec-da7f-36a8-5048-817177756bc7@web.de>
Date: Sat, 19 Mar 2022 12:52:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Eric Wheeler <cocci@lists.ewheeler.net>, cocci@inria.fr
References: <a2422ea-5dd9-753-cf9b-97439e7db462@ewheeler.net>
 <75237f17-66ae-21c3-8796-c656315d99d0@ewheeler.net>
 <db684d7-8b40-d3be-969f-cb399e39d4c3@ewheeler.net>
 <e7182c14-5551-111d-7c41-16fb747fe505@web.de>
 <alpine.DEB.2.22.394.2203191219370.3204@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2203191219370.3204@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r1eo7g3fGQZf+r4yUMIdsGqmnp9TnkCgvfnqdg5EbZzb7hnORuW
 G7tOtdllqkqeF0gC9malqaQYmvgU2ktKQCO4h+cNH/orDtZLnahQAVhb1JQoadkPdtw9nZD
 NONdKcBd9aSrsBClZDFr0byyacCPMb8eHEDm7+b8c3QhR3d8Ab8YKz2ODD4jYzJJIMXi0L5
 +s37m+uuucP4TEeIPUI0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YN6/Kmoa9Us=:IuOIK4HMAT3lzIU73YO7AZ
 Uu8JhQ6JUMWDACTjNOVuJbc2F3sLz0LLeE9RDyq7n6y0OIxy7FUqgXSKzdLoYVXYwIynpc9wl
 1UkFJ9tiJXhxsq+CgUkDDw3zXT6kiHoP2mScXXFHAwAWFIXHe2onkJavXxgzBVaOAlcr3YzA0
 2+rThNp8o6qVhWmhjG68IbvEcqnhrTGstAh63zj1H0kq/JHSxFSlxgISPCzcxwlAr9TbnmZd0
 Kr3zLxsqhlN9A6p9j65YX88JRfg7Nm+/zDbN7Hw2ZY2bqATqMODWSo9slhsZZ2/lbn3BVsXkl
 QKB9icimimnFf+i3dA4FOrMhWaSpWTuuNo+zGAWeRjSOlbp+GPd30CqDtKJ8Efw8d6A87WnQm
 I8VLG5XAl9E/gxrdzS6DE7rDZMd3NuCzMuQlM1TDU2waP13rLnc+fsGVOGq+6FYkrBulgJdcz
 LUtyjXq/sEGfSG9D5lmZ5wkkzZkg1/4rgK68Qg6LfCA4zHO89wKgoXATW35kRL6XnB4Ix4n3/
 +knbAtaZbLsVibQcxIOvGkS3ClaCOtv69DdDNM1AYM0dujgH284WM1AbVpkAWc/FlXVYu7bQn
 SruG8xBXGK6FMTqoU2cZow4c/8pI+UpNPetLQN8GU6D4+bPc953ZA23dSUs67pEdk7U9pyDPi
 Ol3q2QwoghdBJdzfKTBf6CaL5SREps+Wg0g9AtRSB/SlbzahA6VGn4KseEW3jg0wVUGTluK7X
 M5iF0PYOm7nBQY6Rn2gawBP88o9Rc/MycDgJuJ/x54+W+nVwzy3yd0/i1z0VkKYOe2ixedZgL
 ofBU6+t8XSjhMmarOHhYYxtMSHQ2pPuFjaJcKiMc24gvzHAvtRcloL5buNzgZPXNL4Fvc2M0Y
 SRn1tEcBA1nd0Qk4QKXrPwi1TfcDSds3kXHm9hkEwb3Xt4Kx6YjZ3i3Aajw3x8iWbBJHQDljC
 LaMlvmlfQwd7CXNMOuLoPQYAJdfSoUk1TqnJ2oObfqk0TzGvUeCrAmKxmqmBW1ioPPNc10Byr
 VPqOj9fCHxwmVJQsorjGSifkg3vvSkw3TSM8XiM/QMtTiM2QNVwSNcNv7of7UCzkvRgqRLKUH
 gj6vfFHbhrPUjk=
Subject: Re: [cocci] Can fields from structs be used added code as
 expressions?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 241
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/869caaec-da7f-36a8-5048-817177756bc7%40web.de>

>>> 	// Add the compare_T() function call and compare_T function definitio=
n for each type:
>>> 	@ r2 @
>>> 	identifier struct_name.I;
>>> 	fresh identifier FN =3D "compare_"##I;
>>> 	@@
>>> 	f()
>>> 	{
>>> 	++  FN();
>>> 	}
>>> 	++void FN(){}
=E2=80=A6
>> I doubt that you would like to add only a single function (or macro) ca=
ll
>> within the implementation of the function =E2=80=9Cf=E2=80=9D.
> He has ++, which allows adding as many definitions and calls as there ar=
e
> values of name.I.


How do you think about the usage of further change details?

* Should the identifier =E2=80=9Cf=E2=80=9D be a metavariable?

* Additional context information for relevant source code places

* Non-empty function implementations are probably preferred, aren't they?

Regards,
Markus

