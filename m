From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 22 Mar 2013 18:31:47 +0100 (CET)
Subject: [Cocci] Invitation to the thesis defense of Suman Saha (fwd)
Message-ID: <alpine.DEB.2.02.1303221829451.1935@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

If you are in the Paris area and are interested in bug finding in C code,
you may be interested in coming to the following PhD defense on Monday.
We plan to make the tool developed as part of this PhD publicly available
shortly.  It has already been used to find quite a number of
resource-release omission faults in Linux, as well as some other systems
software.

julia

---------- Forwarded message ----------
Date: Thu, 21 Mar 2013 13:30:17 +0100
From: Suman <suman.saha@lip6.fr>
To: Tout LIP6 <tout-lip6@lip6.fr>
Subject: Invitation to the thesis defense of Suman Saha


Hello,

I am pleased to invite you to my thesis defense.

My thesis is entitled "Improving the Quality of Error-Handling Code in
Systems Software using Function-Local Information"

The defense will take place Monday, March 25th at 14:00 pm at Jussieu in
room 25-26/101

---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------
-----------------------

Abstract

Adequate error-handling code is essential to the reliability of any systems
software. On an error, such code is responsible for releasing acquired
resources to restore the system to a viable state. Omitting such operations
leads not only to memory leaks, but also to system crashes and deadlocks.

The C language does not provide any abstractions for exception handling or
other forms of error handling, leaving programmers to devise their own
conventions for detecting and handling errors. The Linux coding style
guidelines suggest placing error handling code at the end of each function,
where it can be reached by gotos whenever an error is detected. This coding
style has the advantage of putting all of the error-handling code in one
place, which eases understanding and maintenance, and reduces code
duplication. Nevertheless, this coding style is not always applied. In the
first part of the thesis, we propose an automatic program transformation
that transforms error-handling code into this style. We have implemented
this algorithm as a tool and have applied this tool to five directories
(drivers, fs, net, arch, and sound) in Linux 3.6 kernel source code as well
as to five widely used open-source systems software projects: PostgreSQL,
Apache, Wine, Python, and PHP. This tool successfully converts 22% of the
conditionals containing state-restoring error-handling code that have the
scope to merge code into one, from the basic strategy to the goto-based
strategy.

Even when error handling code is structured according to the Linux coding
style guidelines, the management of the releasing of allocated resources
remains a continual problem in ensuring the robustness of systems software.
Finding such faults is very challenging due to the difficulty of
systematically reproducing system errors and the diversity of system
resources and their associated resource release operations. To address these
issues, over 10 years of research has focused on macroscopic approaches that
globally scan a code base for common resource-release operations. Such
approaches are notorious for their high rates of false positives, while at
the same time, in practice, they leave many faults undetected.

In the second part of the thesis, we propose a novel microscopic approach to
finding resource- release faults in systems software, taking into account
such software?s diversity of resource types and resource-release operations.
Rather than generalizing from the results of a complete scan of the source
code, our approach achieves precision and scalability by focusing on the
error-handling code of each function. Using a tool, Hector, that we have
developed based on this approach, we have found 485 faults in 19 different C
systems software projects, including Linux, Python, and Apache, with a false
positive rate of 23%, well below the 30% that has been reported to be
acceptable to developers. Some of these faults are exploitable by an
unprivileged malicious user, making it possible to crash the entire system.

---------------------------------------------------------------------------
---------------------------------------------------------------------------
---------------------------------------------------------------------------
-----------------------

The jury will be composed of:

Reporters:


? Mme. Sandrine BLAZY, Professor, University of Rennes 1.


? M. Laurent R?VEILL?RE, Associate Professor, HDR, University of Bordeaux 1

Examiners :


? M. Ola f SPINCZYK, Professor, Technische Universit?t Dortmund


? M. Yannis SMARAGDAKIS, Associate Professor, University of Athens


? M. Fabrice KORDON, Professor, Universit? P & M. Curie


Thesis supervisors :


? M. Gilles MULLER, DR, INRIA

? Mme. Julia LAWALL, DR, INRIA



Kind regards?
Suman Saha
regal.lip6.fr/~Suman.Saha/
