//
//  ViewController.swift
//  FormEngineDemo
//
//  Created by Mikhail Naryshkin on 28/11/2018.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    let form = Form()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(cellTypes: [ExamplePlainCell.self, ExampleSubtitleSwitchCell.self])

        addFormData()
    }

    private func addFormData() {
        let selectionHandler: FormCellSelectionHandler = { cellModel in
            print(cellModel)
        }

        // Section 1
        let examplePlainCellModel1 = ExamplePlainCellModel()
        examplePlainCellModel1.title = "one"
        examplePlainCellModel1.selectionHandler = selectionHandler

        let examplePlainCellModel2 = ExamplePlainCellModel()
        examplePlainCellModel2.title = "two"
        examplePlainCellModel2.selectionHandler = selectionHandler

        let section1 = ExampleFormSection()
        section1.headerTitle = "section 1"
        section1.cellModels = [examplePlainCellModel1, examplePlainCellModel2]

        // Section 2
        let exampleSubtitleSwitchCellModel1 = ExampleSubtitleSwitchCellModel()
        exampleSubtitleSwitchCellModel1.title = "title1"
        exampleSubtitleSwitchCellModel1.subtitle = "title2"
        exampleSubtitleSwitchCellModel1.selectionHandler = selectionHandler
        exampleSubtitleSwitchCellModel1.switchHandler = { cellModel in
            // TODO: Получится ли уйти от кастования через дженерик?
            guard let cellModel = cellModel as? ExampleSubtitleSwitchCellModel else { return }

            print(cellModel.isOn)
        }

        let section2 = ExampleFormSection()
        section2.headerTitle = "section 2"
        section2.cellModels = [exampleSubtitleSwitchCellModel1]

        form.sections.append(contentsOf: [section1, section2])

        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return form.tableView(tableView, numberOfRowsInSection:section)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return form.numberOfSections(in:tableView)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return form.tableView(tableView, cellForRowAt:indexPath)
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return form.tableView(tableView, titleForHeaderInSection:section)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        form.tableView(tableView, didSelectRowAt: indexPath)

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

