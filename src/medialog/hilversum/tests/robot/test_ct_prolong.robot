# ============================================================================
# DEXTERITY ROBOT TESTS
# ============================================================================
#
# Run this robot test stand-alone:
#
#  $ bin/test -s medialog.hilversum -t test_proloog.robot --all
#
# Run this robot test with robot server (which is faster):
#
# 1) Start robot server:
#
# $ bin/robot-server --reload-path src medialog.hilversum.testing.MEDIALOG_HILVERSUM_ACCEPTANCE_TESTING
#
# 2) Run robot tests:
#
# $ bin/robot /src/medialog/hilversum/tests/robot/test_proloog.robot
#
# See the http://docs.plone.org for further details (search for robot
# framework).
#
# ============================================================================

*** Settings *****************************************************************

Resource  plone/app/robotframework/selenium.robot
Resource  plone/app/robotframework/keywords.robot

Library  Remote  ${PLONE_URL}/RobotRemote

Test Setup  Open test browser
Test Teardown  Close all browsers


*** Test Cases ***************************************************************

Scenario: As a site administrator I can add a proloog
  Given a logged-in site administrator
    and an add proloog form
   When I type 'My proloog' into the title field
    and I submit the form
   Then a proloog with the title 'My proloog' has been created

Scenario: As a site administrator I can view a proloog
  Given a logged-in site administrator
    and a proloog 'My proloog'
   When I go to the proloog view
   Then I can see the proloog title 'My proloog'


*** Keywords *****************************************************************

# --- Given ------------------------------------------------------------------

a logged-in site administrator
  Enable autologin as  Site Administrator

an add proloog form
  Go To  ${PLONE_URL}/++add++proloog

a proloog 'My proloog'
  Create content  type=proloog  id=my-proloog  title=My proloog

# --- WHEN -------------------------------------------------------------------

I type '${title}' into the title field
  Input Text  name=form.widgets.IBasic.title  ${title}

I submit the form
  Click Button  Save

I go to the proloog view
  Go To  ${PLONE_URL}/my-proloog
  Wait until page contains  Site Map


# --- THEN -------------------------------------------------------------------

a proloog with the title '${title}' has been created
  Wait until page contains  Site Map
  Page should contain  ${title}
  Page should contain  Item created

I can see the proloog title '${title}'
  Wait until page contains  Site Map
  Page should contain  ${title}
