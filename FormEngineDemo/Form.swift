//
//  Form.swift
//  FormEngineDemo
//
//  Created by Mikhail Naryshkin on 12/12/2018.
//

import UIKit

final class Form {
    var sections: [FormSection] = []
}

extension Form {
    // UITableViewDataSource  Пока копирование методов.
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].cellModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = sections[indexPath.section].cellModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.reuseIdentifier, for: indexPath)

        if let formConfigurableCell = cell as? FormConfigurableCell {
            formConfigurableCell.configureWith(cellModel: cellModel)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].headerTitle
    }
}

extension Form {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellModel = sections[indexPath.section].cellModels[indexPath.row]
        cellModel.selectionHandler?(cellModel)
    }
}

extension UITableView {
    func register(cellTypes: [UITableViewCell.Type]) {
        for cellType in cellTypes {
            let reuseIdentifier = String(describing: cellType)
            self.register(cellType, forCellReuseIdentifier: reuseIdentifier)
        }
    }
}
