#! /usr/bin/env python

# Schedules, 2006-2007
# Start WW36 (2006-09-03)

import time, datetime

# Preschool Service Teams (10:15-11:45)
psts = (
    ("Kate Wilkins <>", "Vicki Coates <>", "Gus Coates <>", "Jaime Coates <>"),
    ("Mark Hesse <>", "Logan Ballard <>", "Jacob Harrell <>"),
    ("Dave Jarvis <>", "Wade Scarbrough <>"),
    ("Micah Elliott <>",),
    ("Karen Lindseth <>", "Leif Lindseth <>"),
)

# Nursery Class Teams (9:15-10:20AM)
ncts = (
    ("Heidi Hanson <>",),
    ("Pam Harrell <>",),
    ("Marg Mathew <>",),
    ("None <>",),
    ("Maureen McLain <>",),
)

# Nursery Service Teams (10:15-11:45AM)
nsts = (
    ("Heidi Hanson <>", "Erin Kelley <>"),
    ("John Prouty <>", "Jillian Prouty <>"),
    ("Marg Mathew <>", "Cherie Lorenzo <>"),
    ("Steve Palau <>", "Megan Palau <>", "Seth Pickens <>"),
    ("Helen Winberg <>", "Maureen McLain <>"),
)

#teams = ('Preschool Service Team

# Spans 2006-W36 through 2007-W35.
teamWeeks = (
    (36, 40, 44, 49, 2, 6, 10, 14, 19, 23, 27, 32),
    (37, 41, 45, 50, 3, 7, 11, 15, 20, 24, 28, 33),
    (38, 42, 46, 51, 4, 8, 12, 16, 21, 25, 29, 34),
    (39, 43, 47, 52, 5, 9, 13, 17, 22, 26, 30, 35),
    (39, 52, 18, 31),
)

# Determine present week.
today = datetime.date(*time.gmtime()[:3])
thisWeekNo = today.isocalendar()[1]
# or simply d.strftime("%W")

def weekToDate(week):
    startOfYear = datetime.date(2006, 1, 1)
    week0 = startOfYear - datetime.timedelta(days=startOfYear.isoweekday())
    sun = week0 + datetime.timedelta(weeks=week)
    #print sun
    return sun

def printTeams():
    print '\nTeam Roster'
    #print '===========\n'
    for team in psts, ncts, nsts:
        print 'Preschool Service Team:'
        for member in team:
            #print '   ', member
            print ','.join(member)
        print

def printFullSchedule():
    print '\nWeekly Distribution'
    #print '===================\n'
    for teamNo in range(len(teamWeeks)):
        #print 'Week:', teamWeeks[teamNo]
        print 'Sundays,',
        sundays = [ '%s'%weekToDate(week) for week in teamWeeks[teamNo] ]
        #for week in teamWeeks[teamNo]: print '%s,'%weekToDate(week),
        print ', '.join(sundays)
        print 'Preschool Service Team,', ','.join(psts[teamNo])
        print 'Nursery Class Team,', ','.join(ncts[teamNo])
        print 'Nursery Service Team,', ','.join(nsts[teamNo])
        print

def sendMail(teamList):
    for member in teamList:
        print 'Mailing:', member

def mailTeams():
    for teamNo in range(len(teamWeeks)):
        if thisWeekNo in teamWeeks[teamNo]:
            print 'Mailing teams corresponding to week', teamNo
            sendMail(psts[teamNo])
            sendMail(ncts[teamNo])
            sendMail(nsts[teamNo])

printTeams()
printFullSchedule()
weekToDate(31)
