#!/usr/bin/python
# -*- coding: utf-8 -*-


import wx
import os
import shutil
from wx import html

class PrestoFrame(wx.Frame):
    def __init__(self,parent):
        self.title = "PRime"
        wx.Frame.__init__(self,parent,-1,self.title,wx.DefaultPosition,size=(600,600),style= wx.SYSTEM_MENU | wx.CAPTION | wx.CLOSE_BOX | wx.MINIMIZE_BOX)
        self.initStatusBar()
        self.createMenuBar()
        self.createToolBar()

        self.Bind(wx.EVT_CLOSE,self.OnCloseWindow)
	self.main = wx.SplitterWindow(self)
        self.image_pane = wx.SplitterWindow(self.main)
        self.image_pane.SetMinimumPaneSize(100) #project panel
        self.tool_pane = wx.SplitterWindow(self.main)
        self.tool_pane.SetMinimumPaneSize(100) #action panel
	self.main.SplitVertically(self.tool_pane,self.image_pane,75)
	self.image_pane.SetBackgroundColour("white")
	#img = wx.Image('lena.bmp', wx.BITMAP_TYPE_ANY)
	#self.imageCtrl = wx.StaticBitmap(self.image_pane, wx.ID_ANY,wx.BitmapFromImage(img))
        self.State = "1"
	self.filename = None
        self.Show(True)

    def initStatusBar(self):
        self.statusbar = self.CreateStatusBar()

    def menuData(self):
        data = [("&File",(
                  ("&Open",wx.ID_OPEN,"Open Image",self.OnOpen),
                  ("&Save",wx.ID_SAVE,"Save Image",self.OnOpen),
                  ("&Save&As",wx.ID_SAVE,"Save Image As",self.OnSaveAs),
                  ("","","",""),
                  ("&Quit",wx.ID_EXIT,"Quit",self.OnCloseWindow))),
                ("&Edit",(
                  ("&Add Files",-1,"Add Verilog source files",self.OnOpen),
                  ("&Remove Files",-1,"Remove Verilog source files",self.OnOpen),
                  ("&Add Configuration",-1,"Add the system Configuration file",self.OnOpen),
                  ("&Clear Transcript",-1,"Clear the transcript window",self.OnOpen),
                  ("&Clear Project files",-1,"Remove all project files",self.OnOpen)
                )),
                ("&About",(
                  ("&About",-1,"About",self.OnAbout),
               ))]
        return data

    def createMenuBar(self):
        menuBar = wx.MenuBar()
        for eachMenuData in self.menuData():
            menuLabel = eachMenuData[0]
            menuItems = eachMenuData[1]
            menuBar.Append(self.createMenu(menuItems), menuLabel)
        self.SetMenuBar(menuBar)

    def createMenu(self,menuData):
        menu = wx.Menu()
        for eachItem in menuData:
            if len(eachItem) == 2:
                label = eachItem[0]
                subMenu = self.createMenu(eachItem[1])
                menu.AppendMenu(wx.NewId(), label, subMenu)
            else:
                self.createMenuItem(menu, *eachItem)
        return menu

    def createMenuItem(self,menu,label,item_id,status,handler,kind=wx.ITEM_NORMAL):
        if not label:
            menu.AppendSeparator()
            return
        menuItem = menu.Append(item_id,label,status,kind)
        self.Bind(wx.EVT_MENU,handler,menuItem)

    def OnCloseWindow(self,event):
        self.Destroy()

    def OnOpen(self,event):
        dlg = wx.FileDialog(self, "Open PResto project...", os.getcwd(),style=wx.OPEN,wildcard="Image files (*.bmp) |*.bmp")
        if dlg.ShowModal() == wx.ID_OK:
            self.in_filename = dlg.GetPath()
	img = wx.Image(self.in_filename, wx.BITMAP_TYPE_ANY)
	imageCtrl = wx.StaticBitmap(self.image_pane, wx.ID_ANY,wx.BitmapFromImage(img))
        self.State = "0"
        dlg.Destroy()

    def OnSaveAs(self,event):
	#if self.State == "0":
            dlg = wx.FileDialog(self,"Save project as...",os.getcwd(),style=wx.SAVE|wx.OVERWRITE_PROMPT)
            if dlg.ShowModal() == wx.ID_OK:
                filename = dlg.GetPath()
                #if not os.path.splitext(filename)[1]:
	        #    out_filename = filename
		shutil.copyfile(self.in_filename,filename)
            dlg.Destroy()

    def createToolBar(self):
        toolbar = self.CreateToolBar()
	ftool = toolbar.AddLabelTool(wx.ID_ANY, 'Save', wx.Bitmap('folder.png'))
        stool = toolbar.AddLabelTool(wx.ID_ANY, 'Save', wx.Bitmap('save.png'))
	toolbar.Realize()
	self.Bind(wx.EVT_TOOL, self.OnOpen, ftool)

    def OnAbout(self,event):
        dlg = PRestoAbout(self)
        dlg.ShowModal()
        dlg.Destroy()

class PRestoAbout(wx.Dialog):
    text = '''
<html>
<body bgcolor = "#ACAA60">
<center><table bgcolor = "#455481" width="100%"cellspacing="0"
cellpadding="0" border-"1">
<tr>
<td align="center"><h1>PRime</h1></td>
</tr>
</table>
</center>
<p><b>PR based Image Manipulation Environment:</b> A demonstration platform for image processing using FPGA partial reconfiguration  </b></p>
<p>Copyright &copy 2012-2013 Vipin K & Suhaib Fahmy, Nanyang Technological University, Singapore</p>
</body>
</html>
'''
    def __init__(self,parent):
        
        wx.Dialog.__init__(self,parent,-1,'About PResto',size=(400,300))
        html = wx.html.HtmlWindow(self)
        html.SetPage(self.text)
        sizer = wx.BoxSizer(wx.VERTICAL)
        sizer.Add(html,1,wx.EXPAND|wx.ALL,5)
        self.SetSizer(sizer)
        self.Layout()

def main():
  ex = wx.App()
  PrestoFrame(None)
  ex.MainLoop()

if __name__ == '__main__':
  main()

