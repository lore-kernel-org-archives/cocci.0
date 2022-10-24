Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2FAC38A2D
	for <cocci@archiver.kernel.org>; Mon, 24 Oct 2022 07:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:message-id:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=h7qRiEGsaOlhwznA9WNWGbkGWXhCdquQZx4HiBXhBKg=;
  b=GQyP9PEK9UodwnzXfxnFKU1cEv+74DF9jiDfTRLHuH8Q4oQAaPtW5L3q
   z9do4KgTwERZs787BI1I/xcUFvuOBhh4ajuk1+nRIK4Ju+2/jcU3H0+Wr
   mjXsI3GC9JvC9HxsjTacvzSYqMVlvDU0wJIwkNNeS02SQ49yO3T9NGjjW
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.95,207,1661810400"; 
   d="scan'208";a="67999346"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Oct 2022 09:18:11 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9280EE013D; Mon, 24 Oct 2022 09:18:11 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E8E05E0130
	for <cocci@sympa.inria.fr>; Mon, 24 Oct 2022 09:18:06 +0200 (CEST)
IronPort-SDR: 63563c2e_9SkNOdTLnR3l0szHxMlSZISs/v4Bg+yRMLy7EtYvR7M4wWy
 JTqNQBFh7Vn8sTQ43VlHEiVVg5H/j8JE0GcQwTg==
X-IPAS-Result: =?us-ascii?q?A0AjBwA3O1ZjhwMP49RaHQEBPAEFBQECAQkBFYEqJ4FDA?=
 =?us-ascii?q?maBAVYuBAtFA4RLkRppkgGEXodSDwEDAQ0UAQEjCAECBAEBP4RGAoRxAh0HA?=
 =?us-ascii?q?QQ0EwECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEARMBAQEZCRcHDhAFI?=
 =?us-ascii?q?oVoDYI1KQGDZAECAgEjHQEBESYBDwUGGgImAgJXBhMRgmwBgmwBAw0jBwyrD?=
 =?us-ascii?q?4EygQGCCAEBBoFAAYMNHywiU4FdAwaBESoCAQGHIYRbg2N6JxCBVUSBSIJ3P?=
 =?us-ascii?q?oJLgWUUg1eCZo8Phkc4A0QdQANGMg1RHDEnDgkfHA4XDQUGEgMgbgVBDygvZ?=
 =?us-ascii?q?yscGweBDCooFQMEBAMCBhMDIgINKTEUBCkTDy0HI3EJAgMhZQUDAwQoLAMJQ?=
 =?us-ascii?q?AclJDwHWDoBBAMCECI8BgMJAwIkgUoxJgUDDRclCAVOBAg6AgUGUhICChEDE?=
 =?us-ascii?q?g8GJ0cOSj45FgYnRAE0Dw4WA2OXAoIRgUGVCK9HNAeCHYFIgUsMiW6VEjMDl?=
 =?us-ascii?q?mQGkhMthxOPYY1BmjM1gUQjgVszGiSDNhIBOwMZD445hAyEYYVMPzQCATgCB?=
 =?us-ascii?q?gEKAQEDCQGBVoNwAQGFEgEB?=
IronPort-PHdr: A9a23:45wGthA7EKFUGyOcIxgIUyQUg0kY04WdBeb1wqQuh78GSKm/5ZOqZ
 BWZua82ygORBs6CsqMMotGVmpioYXYH75eFvSJKW713fDhBt/8rmRc9CtWOE0zxIa2iRSU7G
 MNfSA0tpCnjYgBaF8nkelLdvGC54yIMFRXjLwp1Ifn+FpLPg8it2O2+5ZPebx9HiTahb75+I
 wi6oRjVu8ILnYZsN6E9xwfTrHBVYepW32RoJVySnxb4+Mi9+YNo/jpTtfw86cNOSL32cKskQ
 7NWCjQmKH0169bwtRbfVwuP52ATXXsQnxFVHgXK9hD6XpP2sivnqupw3TSRMMPqQbwoXzmp8
 rxmQwH0higZKzE58XnXis1ug6JdvBKhvAF0z4rNbI2IKPZyYqbRcNUHTmRDQ8lRTTRMDYy/Y
 YUPEeQMI/tWoJXzqVQNrxS+CwaiCvn0xz9Un3/7x7E23/g9HQzE2gErAtIAsG7TrNXwLKocV
 vq6zLPLzTXedPNdxDjz6IzGchA7oPGMW71wetfWxEcoDQzFlFaQqZH+Pz+P2eoNt2ab7/BhV
 eKphG4qsA9wrSa0ycs2l4bGmJsYx1bZ/ip23Ig7P8e3SFJnYdG6CptQsTmXOohyT80iR2xlt
 yY3x6EYtZC1ciUHxogrywDbZvCbfYWE/xztWeSMLTp6i3xod72yiRa8/EagxeDxV8m63lZKo
 ydDj9LCuHcN1xnJ5ciGTPtw5kSh1iiV1wDV9O5EJVo4la3BK54uxLM7i5kdsVzbEyPohUn6k
 rWaels69uWq8ejrf7XrqoWSOoNsjgzzPb4il8KiDegiMQUCQ3KX9fm92bH/+0DyXa9Egecsk
 qbDtZDXPcQbqbC9Aw9Syosj7hG/Dyq60NgCk3gIMklKdAiagIf3I13OIfb4Aumjg1m0jjtn2
 u7KMqf/DpnTLHXPiqrtcLZn50NS0AYzyMpQ55NQCrEPOvLzXUrxucTfABAjKQy0wPvnCM5n2
 o0RXWKPDLWZMKLUsV+H/e8uLfeDa5QPtDngNfcp//jugmQhll8HYaapxYcXaGy/Hvl+PUmVe
 WDsjcsZEWcWogo+S/Tnh0GFUTFPe3myXrkx5io7CYKjFYfMXJqhgL2H3CehH51ZfHpKCl6WE
 XvwbYWLR+8MaD6OIs9mijEEUaKuSoE72hGqsA/30LtmLuvR+iIDr5LszsJ55+zVlREo9Dx7F
 d6R02+XTzI8omRdDR0/x6d56WU7gnuE16V+jfFcGZYbs9FASQA8HYzMlecmTdv1X1SSUM2OT
 QODS8+lHCp5Y9Y/2d4IbA4pPty4jQ3YmQeuDaUUkbOjG5E+tK7RiSuib/1hwmrLgfFyx2ItR
 dFCYCj/3vYXH2n7AofIlx/cjKO2beEG2yWL8m6fzG2ItUUeUQhqUKyDU2pMLlDOo4Hf4UXPB
 6SrFaxhKhFInOuLMKhXcZvEiVtcRfHsEMvTaSS9ljT4Hg6Gk4uFd5GiYGABxGPYAUkAnRoU+
 COjPBI9GzznjmbQFj1oGnrwbkmq/eQt4GijQBoSyAeHJ1Zky6Lz+hMRgqmETOgP27sfpCo7g
 zBzAUr7wN/cTdaNz+Z4VINbZ951oFJO1GaD8hd4IoTlNadpwFgXbwVwuUrqkRRxEIRJ18Yw/
 jssy0JpJKSU3UkkFXvQ1I3sOrDRNmj5/Qy+I6/Q1FbE1d+K+6AJoP0molTntQutGwIs6XJim
 9VS1nKd4N3NAm9wGdrUW1w06gM8irXUeCg76KvL2HcqPaT1+j7O1tQ1Bfc0nw66doQXO6eFG
 QnuVswCUpL3cqpwwQfvN09CZ7M3luZ8Jc6tevqY1bT+Oe9hmGjjlmFb+MVn1UnK8SNgS+nO1
 pJDwveC3wLBWS2v6TXp+s3xh41AYikfW2Slzi2xTqtYfK5vZsAmDWm0Isu47spzjdjhVjQLk
 TzrT0NDw8KvdReIOhbY1BdTyF9RjHipgyq+wBRrnjtvoqfVj0msi6zyMREAPGBMXmxri1zhd
 JO1g94tV0+tdwE1lRGh6C4W3oBjrb9kZynWSEZMJW3tKn16F7G3vfyEatJO75UhtWNWVv69a
 BaUUOy1rxwf2iLlV2xQoVJzPxSjoJbkhFpXjGyHLXB8hGXUc4d8yF/T6cfdSvhYwjcdDHMh0
 3+NXAf6ZoTvpp2djN/bv/q7Vn69W5E2E2Gj1o6GuCahpCVrDRC5g/Gvi4jiGAk+3zX80ooiX
 iHJoRDgJ4jzgv7ja6Q9JBYuXQK6sJkfeMk2iIY7iZAO1GJPg5yU+SBCimLvKZBB3qm4anMRR
 DkNytqT4Q7/2UQlIGjaouCxHnib3MZlYMG3J20M3SdopeVDEqSJ9/ppmSVvo1y3hR3ca75xk
 31OrJlmoG5fmOwPtAc3m2+4C6oRAFIeECjijRWO4Pihoa8RaGvlIt3SnAJu2NumCr+FuARVX
 n30L4wjESFH5cJ6KFvQ0Xf359KsaJzKYNkUrBHRjwbYgr0fNscqjvRTz3kCWyq1rTg/xuU8l
 xArwZyqoN3NNTB25KzgSh9Aam+vPplVoGuyy/8EwIDPhdDoRMgEeH1DXYO0H6jxSnRI76uhb
 lvISHpm9z+aAeaNR1bFrh088DSWTNbzcCvIbHgBkYc4HUbbexYZ2VFOGm9mztljR2XIjITga
 BsrtmpXvwCl7EIRm6QwcEOhGmbH+FXyM2hyF8LZdkIJqFkFvRidMNTCvLgqQGcHpNv4/VbLd
 DDcPVotbylBW1TYVQC5eODwuJ+aqbneX7HmZ/rWPefe86oHCarOn8n3lNE8t3OFMsHFVpV7J
 9s83EcLHXVwGsCD3i4KVzRSjSXGKciSuBa7/CRz6MG56vXiHgz1t8OJDPNJPNNj9grT4+/LP
 vOMhCt/NTdT148djX7Oxr8F2VcOiiZoPzCzGLUEvCTJQeregKhSRxIcbipyMoNP4cdelkFVP
 tXHj9ruyrNipvsyFksDSlHr3M2kJIQLL2y7KFLbFROLObCBdlipi4n8ZaKxT6EVjf0B7UTq/
 2zBTAm6Y3LYxFyLH1i1POpBjT+WJklbsYC5KFN2DHT7CcjhYVu9OcN2ijs/xfs1gGnLPCgSK
 2sZEQsFo7uO4Cdfmvg6FXZG6y8vCOCemDuCqcTcJIwXt/RDHSl+0e5XqidfqfMd/GRfSfp5l
 TGH5MZpuE2jm/KTxyBPVR1TtnBUiYjNsUgoasC7vtFQHH3D+hwK92CZDR8H8sBkBtPYsKdV0
 tHTlaj3JV+qEvrR+tYAQdfZIoSLPSh5WfIMMCHZBk0JQGzzXYkwr1NQmree+y/MxqU=
IronPort-Data: A9a23:zZCuP6yySHYjaAPbwil6t+cTwirEfRIJ4+MujC+fZmUNrF6WrkUBx
 mJLDWnSOPyJYTb9KIp0a9vg9UhUvseEnIRgG1dvqVhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefSAOKU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEALjimMc3l48sfrZ8ko35q+q4lv0g3RnDRx1lA+G/5UqJMlHTU2BByOQapVZGOe8W
 9HCwNmRlo8O10pF5nuNy94XQ2VSKlLgFVDmZkl+B8BOtiN/Shkaic7XAhazhXB/0F1ll/gpo
 DlEWAfZpQ0BZsUgk8xFO/VU/r0X0aBuoNf6zXaDXcO75GLCLl7+49VSD0QOI5MI49coLmhq6
 qlNQNwNRkjra+OexbWmVq9zi85lIMSD0IE34Cg6i2uDUrB/HNaYK0nJzYcwMDMYo8lUHuvFI
 ecdZyBuahvofBBFfFsaYH47tLn31yiuKGcDwL6TjY5q+GjokR5W6qCzOcb5Rdi0V990oVnN8
 woq+EygX01EbYXBodafyVqngeTEnAvgSYcKHfu58ORriRud3AQ7DBQJXF+/ieu4j0SkUpReL
 VYV82wgt8APGFeDS97gQ1unrXTCshN0t8ds//MSwy6Jl4/GwyalBW08UCBRce15m8YSWml/v
 rOWpO/BCTtqubyTbHuS8LaIsD+/URT5y0ddPEfoqiNaurHeTJEPYgHnEo48S/Pk5jHhMXSvm
 GHb9HRWa6A70JZTv5hX62wrlN5FSnLhaAMqrjTQRGHNAuhRPdb9P9fABbTzy/tfZLeeVFrpg
 ZTps82Z8fxIEpyH0iCAKAnsIF1Lz6fcWNE/qQc+d3XEy9hL0yD7FWy3yG8mTHqFyu5eJVfUj
 Lb74Gu9HqN7MnqwdrNQaImsEcksxqWIPY27CK6JMoseOcEtL1LvEMRSiai4gD+FfK8EzvFXB
 HtnWZ39ZZrnIfk7nWTtHo/xL5dyl3pulQs/uqwXPzz+jObAPSfLIVv0GALAN6g46r+JugPY7
 55WOKO3J+Z3AIXDjt3s2ddLdzgidCBlbbiv8pA/XrPdfmJORT9wY9ePm+9JU9I+xcx9yLyXl
 kxRr2cDlTITc1WcdV7VAp2iAZuzNatCQYUTZHx2YwnxgSN9Pe5CLs43LvMKQFXuz8Q7pdYcc
 hXPU5zo7i1nGmufqQcOJ4LwtpJjfxmNjAeDdXjtKjsmcpIqA0SD9tb4d0G9vGMDHwimh/sY+
 reA7wL8RYZcZgJACM2NVumj4WnstlcgmcVzfXDyHP9tRGvW/rNHFQnNn94sAsRVKRz81jqQj
 AmXJhEDpNjymYw+8fiXpKXdsYuZKvZyRHRbO2zh6Ze3Kijo0W6xyqBQUOuzXG78VUGl3I6Ad
 Olq3/XHH/lfp2lzsq14CKRO4ZMlwsnG/pt2711DMi3QTlKJDrhAHCG37fNXvPcQ+o4D6BqEZ
 E2f3/J7Z5OLAZrBO3wMLlMHau+j66klqgPK565oHHSgtT5Fx5vZY0B8JBLWtTd8KoFyO4Ybw
 esMns4axgi8qxgyOOa9kSFm2DWQH0METpkYmMkWMK3zhiov72NyU5jWJyv1wZOIMtt3IhYLJ
 B2Qj/H8nLhy/BfJXEcyMnnv5tBjo6oylipE9mJfGGTRqOH53qc2+DZz7QUISh9ky0Qb8uBrZ
 UluGU5HBYSP2DZK3/p8fn2eNDxAIDa7+UXB7UQDu0OEbkuvV03LdHYcP8TU9m8n0mtsRBpp1
 5DG93TAThDRY9DX4is+fWVHus7TZ4V92SOakf/2AvnfOYcxZATUp5OHZE0KmkPBOtwwjkiWn
 tta1r98RoOjPBFBvpBhLZeR0IkRbxW2JGZiZ/VF14FRFEH+fACC4xS/G3qTSOhsecOTqVSZD
 vZwLP1hTx69jSaCjg4KDJ42foNboqQb28ogSJjKe0g266CSvxh4gqL2ryLevlImc/9qsMQ6K
 77SSQ68L3yttSNUtlLJ/eZ5OTueQNgbZQfD8vi/38cXGrki7ux9U0EA/YGlnneSMQc9wROwu
 TnHRq7Jzt5NzZZnsJvsH55iWSS1C4LXf8aZ/D+jt+9haYv0Dv7PkAcOuHzLAh9zP4ZNa+9ol
 L+IjsH77HnFsJkyTWrdvZuLTItN2umfQ8tVNZjRAERBvC7fRvLp3QQPy1q4JbNNjtlZwMutH
 Cm8ScmocO8qS8Vv/2JUZwdeAiQiJfzONIm4nhyErtOIFhQ5+i7EJon+9XbWMEdqRhVRMJj6U
 gLJq/Ki4+5Dl7t1BTgGOaBWM8ctahurE64rbMb4ujSkH3GlyAHK8KfrkR07ryrHED+YGcL9+
 ojIXQX6aA/0gqzT0dVFqMZni3X71pqmbTUYJSrxOuKaigxWyEYDKvkBd4oLANdYn0QeEX0+i
 C7lNAMf5efVBFyosikQJPz8Uw3ZCuFm1hLROGky503NA8upLNroPVainxuMJ19pdzGlwOzPx
 RTyPJHvFkDZ/6yFjtr/KhB2bSmLCx8aKr81FZjBrvHP
IronPort-HdrOrdr: A9a23:uo8eVavcH0thax+swzoaHQBj7skDhNV00zEX/kB9WHVpmwKj9/
 xG+85rrSMc6QxhOk3I/OrqBEDuewK4yXcY2+cs1JaZLW3bUS6TXedfBOjZrwEIeReQygc178
 4JHpSWSueAdGSTSK3BkW6F+r0bsbq6Gc6T5Nv281coax12YKd96ApDBh+cCVAefng4OXNDLu
 vn2iJdzQDQBEj/g/7LekUtbqz+h5numIj9aRALQyM28QXmt0LS1FZwfiLz4isj
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,207,1661810400"; 
   d="scan'208";a="67999323"
X-MGA-submission: =?us-ascii?q?MDF8ARTDZJ1w4gNJG5WZmR5ObUYC6ytNFWMEUl?=
 =?us-ascii?q?XVhe73a3UqQMvEVSTJnL3j65C/ffANcEKSd9IRkrNU3gwZZC2+dPW8Dh?=
 =?us-ascii?q?jx9BtCb95DAh1RNMwYIJlu8RmCIfMNkCBGQRwAP0vlo5Z5LDX/9cKJec?=
 =?us-ascii?q?iqTSvc27+NM3c2qK0OoFebCg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 09:18:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1666595884; bh=ygkNmr8TC6dpYZNKt3GIGvZLYZsEGJ5jWJ9rOSBU6n4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wtMjcRPl0d5cjTiGdXyy8FRBRVgJ76RjIzxi34tVG/HbqrpVaDks8e+NLYjMMSfUB
	 5b6ibi4FhBklrBOcr9t3hiZNWNJ3Am8fl/wXT84goDv8c0DJTGtNj+UkxRvMx7z2DD
	 QiXz2xiEbqllnAaCj3q32dKG5nZsm7P5b0Wg6f9RapQUtbB07cZPgTwPPWEcHdJlv1
	 zkD0hWQauOUyjq00xO3W9YA7K1fN/4UNqRU6uIFQzE1lVKmuAahj0gJqihfDLs9gs9
	 XZ7abbxpPcVIwnkZywDflX6B5ShxAMXjJt6KcKpbaHlEZsNxIXpAQHhxBDaflhPXbV
	 lSifl0Vela+WQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [94.31.80.160] ([94.31.80.160]) by web-mail.web.de
 (3c-app-webde-bs11.server.lan [172.19.170.11]) (via HTTP); Mon, 24 Oct 2022
 09:18:04 +0200
MIME-Version: 1.0
Message-ID: <trinity-149cf2a6-991c-445a-b824-892ea1c8cefc-1666595884527@3c-app-webde-bs11>
From: Markus Elfring <Markus.Elfring@web.de>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Oct 2022 09:18:04 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <Y1WX3FNT1xiQfSgD@zx2c4.com>
References: <CAHmME9rTWvUxsM-sFZh1r+D5gb-8rbHmeWiFEfobkjxDRrZO1Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2210200705030.2988@hadrien>
 <CAHmME9p7nTuAOS87NYKhbhh1rF-XJBkuWjjmHbrkiJUrth5XHQ@mail.gmail.com>
 <trinity-38dbc083-0911-4042-984d-ad608cefb8da-1666523912279@3c-app-webde-bap48>
 <Y1WX3FNT1xiQfSgD@zx2c4.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:TzgF887Qfwynpmc2qbRRFW/5Bh2MX2nHsGspHWul01jMOkjYqo2xXduPrfPJogeXEJ3RU
 KNgH0cnpLJzShR3vIfIbg0Wiybs6JfmR9QRhBYeLgLDdaGuNhawpyz/o2kPP5opfj7knvcYBvUgV
 5fBOTKgXpNttxLqB/P2SYOUSP53Pscz5ULWY4HKnLGRA5qx/S87bG0TpUIlWs0lCrdzmrCeZXZIH
 y3A3tgdv8lzRvji38dTtuIXu+/Ic6UPzdV7EWXgLbU4wmwjIsoNC/e11mR1v2hd6jnQLHMXxmOeJ
 vY=
UI-OutboundReport: notjunk:1;M01:P0:HFJXVPj4zEI=;Zd+q4gi6iZAuuqXvbCYdu+FIe72
 QNw3MwYzOg2ZWuztOIGWa95zshtdtZ4UuFhfz3J8MG6cL7xx9ZKEzunFo2AxL/ULImORQLXD1
 KAlODqgddWPdqZpCtV85rO26uG7OQMhe7L80JZudQTxBHHAlfA4U2/UYq2J1Eycu/GjozGSmU
 y4oxin+T9IDDohF6cAM2xqZzhKzeqCrpDinaZd397aqz7zd/TUPsTXQKfR0cs4KppPgz2nzXu
 /Y26F4PspkqAxFLU29hTUgu0fPVm4s8e0Gal5/f89nxuI6psywG/d9GwCjeyplrO/9si3lxaL
 RKWnp6OuUxxxn51CfQHP5jVdyb6aYnMiEtBoV5arKfOdgpexcKkmvudpfp+5DLo85wxpRmvnd
 JhvoNBfS82Iw+Xx5npv3h/uV03yh5ZOcp263J4l/NkXM9+mIKQvEGEflTQtH5+Lk6XgLUdsJC
 5SglYpmKwGnmKyhdJ2q50unurEZkOW84EPbCqkAOiU0MgwIzim7mpwfzbFQQDvdIsvZ8E8liu
 NNIsXfmhWACmXr1ZXGJfTeP0GVEBU3aqHdKDcUubyJUKr1dD0DGkbgop4CoO6S27zTAVTPBat
 M3GaV2WJEHXhwYgP/LGYxS9DwryEj1ZMpuDnwIVeFq9FthfVMSjJ/iYR4jlw73JdCzC5nzZ1p
 YxUXWYEI4AaDgNMO3ABPdmpFhAF0MVdrmDwbT0JOTZ/Spsn9mArCIqhovS6jj4T9os7hWRR5w
 boJmhYd2eKi6i/NrP0gwosJrYFdqnMoY9X3LHNoruuhxdUeU2alor9o+reY9MU8C+yOuVsymz
 faa8byiljDqzWKADWvI2PYFQ==
Subject: Re: [cocci] Checking the replacement =?UTF-8?Q?=E2=80=9Cget=5Fran?=
 =?UTF-8?Q?dom=5Fu32=5Fabove=280=29=E2=80=9D?=
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 680
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/trinity-149cf2a6-991c-445a-b824-892ea1c8cefc-1666595884527%403c-app-webde-bs11>

> > > I just sent these in:
> > > https://lore=2Ekernel=2Eorg/lkml/20221022014403=2E3881893-5-Jason@zx=
2c4=2Ecom/
> >=20
> > I find the following code details also suspicious from two SmPL rules=
=2E
> >=20
> > =E2=80=A6
> > -   } while (!I);
> > +   I =3D get_random_u32_above(0);
> > =E2=80=A6
> > -   } while (I =3D=3D 0);
> > +   I =3D get_random_u32_above(0);
> > =E2=80=A6
> >=20
> >=20
> > * Should such case distinctions be reconsidered?
> >=20
> > * Can different function parameters become relevant here?
>=20
> * Can you be more specific?
>=20
> I have no idea what you're getting at=2E

I doubt that you would like to map the condition checks =E2=80=9C!I=E2=80=
=9D and =E2=80=9CI =3D=3D 0=E2=80=9D
to the same function call=2E

If you would insist to cobble them together, I imagine that it would be ni=
cer
to combine discussed SmPL rules into one by using SmPL disjunctions accord=
ingly=2E

Regards,
Markus
