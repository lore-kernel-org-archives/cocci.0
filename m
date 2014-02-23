From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 23 Feb 2014 17:33:57 +0100
Subject: [Cocci] Remove unnecessary null pointer checks?
In-Reply-To: <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
Message-ID: <530A22F5.4000301@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Something goes wrong with the switch pattern. I would have to look into why.

Thanks for your quick feedback.


> But I think that a switch is highly improbable for making such a test,
> so you could just drop it.

I just try to make the discussed filter patterns as complete as possible.


> You may also want to specify that input has pointer type, since you are
> actually looking for NULL tests, not zero tests.

This is an important implementation detail which I would like to generalise so
that also functions like "btrfsic_process_written_block" will be safely found by
further source code searches.
https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tree/fs/btrfs/check-integrity.c?id=878a876b2e10888afe53766dcca33f723ae20edc#n1835

This one was found by the previous simple pattern for example despite I expected
it to handle primarily pointer data types instead of an "unsigned int" in this case.

Regards,
Markus
