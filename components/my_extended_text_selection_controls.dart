import 'package:education_app/components/app_text.dart';
import 'package:education_app/constants.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:toast/toast.dart';
import 'package:flutter_colorpicker/utils.dart';
import 'dart:math' as math;

// Minimal padding from all edges of the selection toolbar to all edges of the
// viewport.

const double _kToolbarScreenPadding = 8.0;
const double _kToolbarHeight = 44.0;
const double _kHandleSize = 22.0;

///
///  create by zmtzawqlp on 2019/8/3
///

class MyExtendedMaterialTextSelectionControls
    extends MaterialExtendedTextSelectionControls {
  final Function colorHandler;

  MyExtendedMaterialTextSelectionControls({this.colorHandler});
  @override
  Widget buildToolbar(
    BuildContext context,
    Rect globalEditableRegion,
    double textLineHeight,
    Offset position,
    List<TextSelectionPoint> endpoints,
    TextSelectionDelegate delegate,
  ) {
    assert(debugCheckHasMediaQuery(context));
    assert(debugCheckHasMaterialLocalizations(context));

    // The toolbar should appear below the TextField
    // when there is not enough space above the TextField to show it.
    final TextSelectionPoint startTextSelectionPoint = endpoints[0];
    final TextSelectionPoint endTextSelectionPoint =
        (endpoints.length > 1) ? endpoints[1] : null;
    final double x = (endTextSelectionPoint == null)
        ? startTextSelectionPoint.point.dx
        : (startTextSelectionPoint.point.dx + endTextSelectionPoint.point.dx) /
            2.0;
    final double availableHeight = globalEditableRegion.top -
        MediaQuery.of(context).padding.top -
        _kToolbarScreenPadding;
    final double y = (availableHeight < _kToolbarHeight)
        ? startTextSelectionPoint.point.dy +
            globalEditableRegion.height +
            _kToolbarHeight +
            _kToolbarScreenPadding
        : startTextSelectionPoint.point.dy - textLineHeight * 2.0;
    final Offset preciseMidpoint = Offset(x, y);

    return ConstrainedBox(
      constraints: BoxConstraints.tight(globalEditableRegion.size),
      child: CustomSingleChildLayout(
        delegate: MaterialExtendedTextSelectionToolbarLayout(
          MediaQuery.of(context).size,
          globalEditableRegion,
          preciseMidpoint,
        ),
        child: _TextSelectionToolbar(
          /* handleCut: canCut(delegate) ? () => handleCut(delegate) : null,
          handleCopy: canCopy(delegate) ? () => handleCopy(delegate) : null,
          handlePaste: canPaste(delegate) ? () => handlePaste(delegate) : null,
          handleSelectAll:
              canSelectAll(delegate) ? () => handleSelectAll(delegate) : null, */

          handleCopy: () => handleCopy(delegate, null),
          handleSearch: () {
            String selectedText = delegate.textEditingValue.selection
                .textInside(delegate.textEditingValue.text);

            colorHandler(selectedText);

            delegate.hideToolbar();
            //clear selecction
            delegate.textEditingValue = delegate.textEditingValue.copyWith(
                selection: TextSelection.collapsed(
                    offset: delegate.textEditingValue.selection.end));

            Toast.show("Search : $selectedText", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          },
          handleLookup: () {
            String selectedText = delegate.textEditingValue.selection
                .textInside(delegate.textEditingValue.text);

            colorHandler(selectedText);

            delegate.hideToolbar();
            //clear selecction
            delegate.textEditingValue = delegate.textEditingValue.copyWith(
                selection: TextSelection.collapsed(
                    offset: delegate.textEditingValue.selection.end));

            Toast.show("Lookup : $selectedText", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          },
          handleColor: (Color color) {
            String selectedText = delegate.textEditingValue.selection
                .textInside(delegate.textEditingValue.text);

            colorHandler(selectedText);

            delegate.hideToolbar();
            //clear selecction
            delegate.textEditingValue = delegate.textEditingValue.copyWith(
                selection: TextSelection.collapsed(
                    offset: delegate.textEditingValue.selection.end));

            Toast.show(
                "Selected Color : $color | Selected Text : $selectedText",
                context,
                duration: Toast.LENGTH_LONG,
                gravity: Toast.BOTTOM);
          },
        ),
      ),
    );
  }
}

/// Manages a copy/paste text selection toolbar.
class _TextSelectionToolbar extends StatelessWidget {
  const _TextSelectionToolbar(
      {Key key,
      this.handleCopy,
      this.handleSearch,
      this.handleLookup,
      this.handleColor})
      : super(key: key);

  final Function handleCopy;
  final Function handleSearch;
  final Function handleLookup;
  final Function handleColor;

  @override
  Widget build(BuildContext context) {
    final border = BorderSide(
      width: 1,
      color: Color(kAppBorderColor),
    );

    return Material(
      elevation: 1.0,
      child: Wrap(
        direction: Axis.vertical,
        children: [
          Wrap(
            children: <Widget>[
              FlatButton(
                  child: AppText(color: Color(kPrimaryColor), text: 'Copy'),
                  onPressed: handleCopy),
              Container(
                decoration:
                    BoxDecoration(border: Border(left: border, right: border)),
                child: FlatButton(
                    child:
                        AppText(color: Color(kPrimaryColor), text: 'Look Up'),
                    onPressed: handleLookup),
              ),
              FlatButton(
                  child: AppText(color: Color(kPrimaryColor), text: 'Search'),
                  onPressed: handleSearch),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              border: Border(
                top: border,
              ),
            ),
            child: Wrap(
              direction: Axis.horizontal,
              children: _getColorBox(),
            ),
          )
        ],
      ),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    );
  }

  List<Widget> _getColorBox() {
    List<Widget> clrBox = [];
    for (var color in kSelectionTextClrList) {
      clrBox.add(
        Container(
          margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            color: Color(color),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                handleColor(Color(color));
              },
              borderRadius: BorderRadius.circular(50.0),
              child: Container(
                width: 40,
                height: 40,
              ),
            ),
          ),
        ),
      );
    }
    return clrBox;
  }
}
