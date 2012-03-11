;;; ----------------------------------------------------------------------------
;;; gtk.radio-menu.item.lisp
;;;
;;; This file contains code from a fork of cl-gtk2.
;;; See http://common-lisp.net/project/cl-gtk2/
;;;
;;; The documentation has been copied from the GTK+ 3 Reference Manual
;;; Version 3.2.3. See http://www.gtk.org.
;;;
;;; Copyright (C) 2009 - 2011 Kalyanov Dmitry
;;; Copyright (C) 2011 - 2012 Dieter Kaiser
;;;
;;; This program is free software: you can redistribute it and/or modify
;;; it under the terms of the GNU Lesser General Public License for Lisp
;;; as published by the Free Software Foundation, either version 3 of the
;;; License, or (at your option) any later version and with a preamble to
;;; the GNU Lesser General Public License that clarifies the terms for use
;;; with Lisp programs and is referred as the LLGPL.
;;;
;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU Lesser General Public License for more details.
;;;
;;; You should have received a copy of the GNU Lesser General Public
;;; License along with this program and the preamble to the Gnu Lesser
;;; General Public License.  If not, see <http://www.gnu.org/licenses/>
;;; and <http://opensource.franz.com/preamble.html>.
;;; ----------------------------------------------------------------------------
;;;
;;; GtkRadioMenuItem
;;; 
;;; A choice from multiple check menu items
;;; 
;;; Synopsis
;;; 
;;;     GtkRadioMenuItem
;;;
;;;     gtk_radio_menu_item_new
;;;     gtk_radio_menu_item_new_with_label
;;;     gtk_radio_menu_item_new_with_mnemonic
;;;     gtk_radio_menu_item_new_from_widget
;;;     gtk_radio_menu_item_new_with_label_from_widget
;;;     gtk_radio_menu_item_new_with_mnemonic_from_widget
;;;     gtk_radio_menu_item_set_group
;;;     gtk_radio_menu_item_get_group
;;; 
;;; Object Hierarchy
;;; 
;;;   GObject
;;;    +----GInitiallyUnowned
;;;          +----GtkWidget
;;;                +----GtkContainer
;;;                      +----GtkBin
;;;                            +----GtkMenuItem
;;;                                  +----GtkCheckMenuItem
;;;                                        +----GtkRadioMenuItem
;;; 
;;; Implemented Interfaces
;;; 
;;; GtkRadioMenuItem implements AtkImplementorIface, GtkBuildable and
;;; GtkActivatable.
;;;
;;; Properties
;;; 
;;;   "group"                    GtkRadioMenuItem*     : Write
;;; 
;;; Signals
;;; 
;;;   "group-changed"                                  : Run First
;;; 
;;; Description
;;; 
;;; A radio menu item is a check menu item that belongs to a group. At each
;;; instant exactly one of the radio menu items from a group is selected.
;;; 
;;; The group list does not need to be freed, as each GtkRadioMenuItem will
;;; remove itself and its list item when it is destroyed.
;;; 
;;; The correct way to create a group of radio menu items is approximatively
;;; this:
;;; 
;;; Example 78. How to create a group of radio menu items.
;;; 
;;; GSList *group = NULL;
;;; GtkWidget *item;
;;; gint i;
;;; 
;;; for (i = 0; i < 5; i++)
;;; {
;;;   item = gtk_radio_menu_item_new_with_label (group, "This is an example");
;;;   group = gtk_radio_menu_item_get_group (GTK_RADIO_MENU_ITEM (item));
;;;   if (i == 1)
;;;     gtk_check_menu_item_set_active (GTK_CHECK_MENU_ITEM (item), TRUE);
;;; }
;;; 
;;; ----------------------------------------------------------------------------
;;;
;;; Property Details
;;;
;;; ----------------------------------------------------------------------------
;;; The "group" property
;;; 
;;;   "group"                    GtkRadioMenuItem*     : Write
;;; 
;;; The radio menu item whose group this widget belongs to.
;;; 
;;; Since 2.8
;;;
;;; ----------------------------------------------------------------------------
;;;
;;; Signal Details
;;;
;;; ----------------------------------------------------------------------------
;;; The "group-changed" signal
;;; 
;;; void user_function (GtkRadioMenuItem *radiomenuitem,
;;;                     gpointer          user_data)          : Run First
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; struct GtkRadioMenuItem
;;; 
;;; struct GtkRadioMenuItem;
;;; ----------------------------------------------------------------------------

(define-g-object-class "GtkRadioMenuItem" gtk-radio-menu-item
  (:superclass gtk-check-menu-item
   :export t
   :interfaces ("AtkImplementorIface" "GtkActivatable" "GtkBuildable")
   :type-initializer "gtk_radio_menu_item_get_type")
  ((group
    gtk-radio-menu-item-group
    "group" "GtkRadioMenuItem" nil t)))

;;; ----------------------------------------------------------------------------
;;; gtk_radio_menu_item_new ()
;;; 
;;; GtkWidget * gtk_radio_menu_item_new (GSList *group);
;;; 
;;; Creates a new GtkRadioMenuItem.
;;; 
;;; group :
;;;     the group to which the radio menu item is to be attached
;;; 
;;; Returns :
;;;     a new GtkRadioMenuItem
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gtk_radio_menu_item_new_with_label ()
;;; 
;;; GtkWidget * gtk_radio_menu_item_new_with_label (GSList *group,
;;;                                                 const gchar *label);
;;; 
;;; Creates a new GtkRadioMenuItem whose child is a simple GtkLabel.
;;; 
;;; group :
;;;     . [element-type GtkRadioMenuItem][transfer full]
;;; 
;;; label :
;;;     the text for the label
;;; 
;;; Returns :
;;;     A new GtkRadioMenuItem.
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gtk_radio_menu_item_new_with_mnemonic ()
;;; 
;;; GtkWidget * gtk_radio_menu_item_new_with_mnemonic (GSList *group,
;;;                                                    const gchar *label);
;;; 
;;; Creates a new GtkRadioMenuItem containing a label. The label will be created
;;; using gtk_label_new_with_mnemonic(), so underscores in label indicate the
;;; mnemonic for the menu item.
;;; 
;;; group :
;;;     group the radio menu item is inside
;;; 
;;; label :
;;;     the text of the button, with an underscore in front of the mnemonic
;;;     character
;;; 
;;; Returns :
;;;     a new GtkRadioMenuItem
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gtk_radio_menu_item_new_from_widget ()
;;; 
;;; GtkWidget * gtk_radio_menu_item_new_from_widget (GtkRadioMenuItem *group);
;;; 
;;; Creates a new GtkRadioMenuItem adding it to the same group as group.
;;; 
;;; group :
;;;     An existing GtkRadioMenuItem
;;; 
;;; Returns :
;;;     The new GtkRadioMenuItem. [transfer none]
;;; 
;;; Since 2.4
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gtk_radio_menu_item_new_with_label_from_widget ()
;;; 
;;; GtkWidget * gtk_radio_menu_item_new_with_label_from_widget
;;;                                                    (GtkRadioMenuItem *group,
;;;                                                     const gchar *label);
;;; 
;;; Creates a new GtkRadioMenuItem whose child is a simple GtkLabel. The new
;;; GtkRadioMenuItem is added to the same group as group.
;;; 
;;; group :
;;;     an existing GtkRadioMenuItem
;;; 
;;; label :
;;;     the text for the label
;;; 
;;; Returns :
;;;     The new GtkRadioMenuItem. [transfer none]
;;; 
;;; Since 2.4
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gtk_radio_menu_item_new_with_mnemonic_from_widget ()
;;; 
;;; GtkWidget * gtk_radio_menu_item_new_with_mnemonic_from_widget
;;;                                                    (GtkRadioMenuItem *group,
;;;                                                     const gchar *label);
;;; 
;;; Creates a new GtkRadioMenuItem containing a label. The label will be created
;;; using gtk_label_new_with_mnemonic(), so underscores in label indicate the
;;; mnemonic for the menu item.
;;; 
;;; The new GtkRadioMenuItem is added to the same group as group.
;;; 
;;; group :
;;;     An existing GtkRadioMenuItem
;;; 
;;; label :
;;;     the text of the button, with an underscore in front of the mnemonic
;;;     character
;;; 
;;; Returns :
;;;     The new GtkRadioMenuItem.
;;; 
;;; Since 2.4
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gtk_radio_menu_item_set_group ()
;;; 
;;; void gtk_radio_menu_item_set_group (GtkRadioMenuItem *radio_menu_item,
;;;                                     GSList *group);
;;; 
;;; Sets the group of a radio menu item, or changes it.
;;; 
;;; radio_menu_item :
;;;     a GtkRadioMenuItem.
;;; 
;;; group :
;;;     the new group
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gtk_radio_menu_item_get_group ()
;;; 
;;; GSList * gtk_radio_menu_item_get_group (GtkRadioMenuItem *radio_menu_item)
;;; 
;;; Returns the group to which the radio menu item belongs, as a GList of
;;; GtkRadioMenuItem. The list belongs to GTK+ and should not be freed.
;;; 
;;; radio_menu_item :
;;;     a GtkRadioMenuItem
;;; 
;;; Returns :
;;;     the group of radio_menu_item
;;; ----------------------------------------------------------------------------


;;; --- End of file gtk.radio-menu-item.lisp -----------------------------------