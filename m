From: christof@warlich.name (Christof Warlich)
Date: Fri, 02 Jan 2015 09:23:27 +0100
Subject: [Cocci] adding function declarations
In-Reply-To: <alpine.DEB.2.02.1501020704450.2072@localhost6.localdomain6>
References: <54A55D15.5020306@warlich.name>
 <alpine.DEB.2.02.1501011700110.2060@localhost6.localdomain6>
 <54A59ACD.4050501@warlich.name>
 <alpine.DEB.2.02.1501012052080.2038@localhost6.localdomain6>
 <54A5DD31.80408@warlich.name>
 <alpine.DEB.2.02.1501020704450.2072@localhost6.localdomain6>
Message-ID: <54A6557F.8030901@warlich.name>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

 > Shouldn't the static also be in the definition? julia

As much as g++ is concerned, the static may or may not be part of the 
definition: At least the following

$ cat xxx.cc
static inline int f();
int f(void) {
     return 0;
}

compiles fine with

$ g++ -c -Wall -Wextra -Weffc++ -Wpedantic xxx.cc
